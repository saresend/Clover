//
//  MainViewController.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/4/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit
import Alamofire
class MainViewController: UIViewController {
    
    @IBOutlet weak var ArticleCollectionView: UICollectionView!
    
    var refreshController = UIRefreshControl()
    
    var elements: [[String: String]] = []
    
    @IBOutlet weak var back_button: UIButton!
    var gradient_layer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gradient_layer.colors = [ UIColor(hex: 0xF8A05A).cgColor, UIColor(hex: 0xF4736A).cgColor]
        
        //Sets Back Button Color
        back_button.imageView?.image = back_button.imageView?.image?.tinted(with: UIColor.white)
        
        gradient_layer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient_layer, at: 0)
        
        /*
         * Set up that yung Collection View
         */
        ArticleCollectionView.dataSource = self
        ArticleCollectionView.delegate = self
        ArticleCollectionView.refreshControl = refreshController
        ArticleCollectionView.alwaysBounceVertical = true
        self.refreshController.addTarget(self, action: #selector(refresh_called), for: .valueChanged)
        
        // Read Data from Server
        Alamofire.request("http://159.65.97.91:8080/get/articles/").responseJSON { response in
            
            if let json = response.result.value {
              
                if let json_elements = json as? [Any] {
                    for element in json_elements {
                        print(element)
                        let parsed = element as? [String: String]
                        print(parsed)
                    }
                    self.ArticleCollectionView.reloadData()
                    self.ArticleCollectionView.reloadInputViews()
                    
                }
            }
        }
        
    }
    
    @objc func refresh_called() {
        refreshController.beginRefreshing()
        self.reloadInputViews()
        refreshController.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func close_clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Article", for: indexPath) as? ArticleCollectionViewCell
        if(cell == nil) {
            cell = ArticleCollectionViewCell()
        }
        let el = elements[indexPath.row] as? [String: String]
        cell?.TitleLabel.text = el?["title"]
        cell?.layer.cornerRadius = 10
        cell?.heart_icon.image = cell?.heart_icon.image?.tinted(with: UIColor.red)
        cell?.clipsToBounds = false
        cell?.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell?.layer.shadowOpacity = 0.4
        cell?.url = (el?["url"])!
        cell?.layer.shadowColor = UIColor.black.cgColor;
        
        cell?.platform_banner.image = cell?.platform_banner.image?.tinted(with: UIColor.orange)
        return cell!
    }
}
extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
