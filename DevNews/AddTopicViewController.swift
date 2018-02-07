//
//  AddTopicViewController.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/6/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {
    
    var gradient_layer = CAGradientLayer()

    @IBOutlet weak var AddTopicField: UITextField!
    @IBAction func Back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
         * AddTopicField UI Config
         */
        gradient_layer.colors = [ UIColor(hex: 0xF8A05A).cgColor, UIColor(hex: 0xF4736A).cgColor]
        gradient_layer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient_layer, at: 0)
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0, y: AddTopicField.frame.height - 1, width: AddTopicField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        AddTopicField.borderStyle = UITextBorderStyle.none
        AddTopicField.layer.addSublayer(bottomLine)
        AddTopicField.attributedPlaceholder = NSAttributedString(string: "Enter Topic Name...",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor(hex: 0xf2ede6)])
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
