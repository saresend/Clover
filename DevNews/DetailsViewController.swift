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
    
    
    var topics = ["Random", "Keywords", "Which", "Should", "Be", "Terms", "Add Topic"]
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

extension DetailsViewController: UICollectionViewDataSource {
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
        cell?.layer.backgroundColor = UIColor.clear.cgColor
        
        if(topics[indexPath.row] == "Add Topic") {
            print("We here")

            cell?.backgroundView?.layer.opacity = 0.3
            cell?.backgroundView?.layer.backgroundColor = UIColor.white.cgColor
        }
        cell?.layer.shadowOpacity = 0.6
        cell?.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell?.layer.shadowColor = UIColor.black.cgColor
        
        return cell!
    }
}

extension DetailsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SettingsCollectionViewCell
        let keyword = cell.title_label.text!
        if(keyword != "Add Topic") {
            let alert = UIAlertController(title: "Would you like to delete " + keyword + "?" , message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            print("User wants to add a topic")
            performSegue(withIdentifier: "AddTopic", sender: self)
        }
    }
    
    
}
