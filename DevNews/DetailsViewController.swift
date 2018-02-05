//
//  DetailsViewController.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/4/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var TopicCollectionView: UICollectionView!
    
    
    var topics = ["BlockChain", "AI", "Frontend", "Backend", "Rust", "Add Topic"]
    var gradient_layer = CAGradientLayer()

    @IBAction func close_clicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
         * Gradient Development
         */
        gradient_layer.colors = [ UIColor(hex: 0xF8A05A).cgColor, UIColor(hex: 0xF4736A).cgColor]
        gradient_layer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient_layer, at: 0)
        
        /*
         * Sets the Controllers for the CollectionView
         */
        TopicCollectionView.dataSource = self
        TopicCollectionView.delegate = self
        
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

}

extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "setting", for: indexPath) as? SettingsCollectionViewCell
        if(cell == nil) {
            cell = SettingsCollectionViewCell()
        }
        
        
        
        cell?.title_label.text = topics[indexPath.row]
        print(topics[indexPath.row])
        print(indexPath)
        cell?.layer.cornerRadius = 10
        cell?.layer.borderWidth = 1
        cell?.layer.borderColor = UIColor.white.cgColor
        

        cell?.clipsToBounds = false
        cell?.layer.shadowOpacity = 0.6
        cell?.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell?.layer.shadowColor = UIColor.black.cgColor
        
        return cell!
    }
    
    
}
