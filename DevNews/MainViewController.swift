//
//  MainViewController.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/4/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var ArticleCollectionView: UICollectionView!
    
    var gradient_layer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gradient_layer.colors = [ UIColor(hex: 0xF8A05A).cgColor, UIColor(hex: 0xF4736A).cgColor]
        
        
        gradient_layer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient_layer, at: 0)
        
        /*
         * Set up that yung Collection View
         */
        ArticleCollectionView.dataSource = self
        ArticleCollectionView.delegate = self
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Article", for: indexPath) as? ArticleCollectionViewCell
        if(cell == nil) {
            cell = ArticleCollectionViewCell()
        }
        cell?.TitleLabel.text = "Testing"
        return cell!
    }
}
