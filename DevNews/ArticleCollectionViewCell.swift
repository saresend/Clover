//
//  ArticleCollectionViewCell.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/4/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ScoreLabel: UILabel!
    var url = "http://medium.com"
    @IBOutlet weak var heart_icon: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var platform_banner: UIImageView!
    
    @IBAction func read_article(_ sender: Any) {

        UIApplication.shared.open(URL(string: url)!, options: [:],
                                  completionHandler: {
                                    (success) in
                                    print("Managed to open the website")
        })
    }
    
}
