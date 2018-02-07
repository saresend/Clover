//
//  AddTopicViewController.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/6/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit
import TransitionButton

class AddTopicViewController: UIViewController {
    
    @IBOutlet weak var priority_label: UILabel!
    @IBOutlet weak var PrioritySlider: UISlider!
    var gradient_layer = CAGradientLayer()
    var button : TransitionButton?  // please use Autolayout in real project
    @IBOutlet weak var AddTopicField: UITextField!
    @IBAction func Back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func value_updated(_ sender: UISlider) {
        print(Int(100 * sender.value))
        priority_label.text = "Topic Priority: " + String(Int(100 * sender.value))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
         * AddTopic Button
         */
        button = TransitionButton(frame: CGRect(x: PrioritySlider.frame.minX , y: PrioritySlider.frame.maxY + 80, width: PrioritySlider.frame.width, height: 60))
        self.view.addSubview(button!)
        button!.backgroundColor = UIColor(hex: 0xe69884)
        button!.setTitle("Add Topic", for: .normal)
        button!.cornerRadius = 20
        button!.spinnerColor = .white
        button!.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
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
    @objc func buttonAction(_ button: TransitionButton) {
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                button.stopAnimation(animationStyle: .expand, completion: {
                    self.navigationController?.popViewController(animated: false)
                    
                })
            })
        })
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
