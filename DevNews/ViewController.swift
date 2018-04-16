//
//  ViewController.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/4/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit
import TransitionButton
import Alamofire

class ViewController: UIViewController  {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var data: [[String: Any]] = []
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var gradient_layer =  CAGradientLayer()
    var button : TransitionButton?  // please use Autolayout in real project
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
         * Super cool button initialization which I was too lazy to do myself
         */
        button = TransitionButton(frame: CGRect(x: passwordTextField.frame.minX , y: passwordTextField.frame.maxY + 80, width: passwordTextField.frame.width, height: 60))
        self.view.addSubview(button!)
        button!.backgroundColor = UIColor(hex: 0xe69884)
        button!.setTitle("Log In or Sign Up", for: .normal)
        button!.cornerRadius = 20
        button!.spinnerColor = .white
        button!.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        
        
        /*
         * Initialization for Gradient Background Layer
         */
        gradient_layer.colors =   [ UIColor(hex: 0xF8A05A).cgColor, UIColor(hex: 0xF4736A).cgColor]
        gradient_layer.frame = self.view.bounds
        self.view.layer.sublayers?.insert(gradient_layer, at: 0)
        
        
        /*
         * Initialize For Hiding Keyboard
         */
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector((tapBlurButton)))
        
        self.view.addGestureRecognizer(tapGesture)
        
        
        /*
         * Below is initialization logic for the borders of the email and password text fields
         */
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        emailTextField.borderStyle = UITextBorderStyle.none
        emailTextField.layer.addSublayer(bottomLine)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        let bottomLine2 = CALayer()
        
        bottomLine2.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1.0)
        bottomLine2.backgroundColor = UIColor.white.cgColor
        passwordTextField.borderStyle = UITextBorderStyle.none
        passwordTextField.layer.addSublayer(bottomLine2)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    // Trying to resign keyboard on tap
    @objc func tapBlurButton() {
        print("Screen tapped")
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? MainViewController {
            dest.elements = self.data
        }
    }
    @objc func buttonAction(_ button: TransitionButton) {
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            Alamofire.request("http://159.65.97.91:8080/get/articles/").responseJSON { response in
                
                if let json = response.result.value {
                    
                    if let json_elements = json as? [Any] {
                        for element in json_elements {
                            print(element)
                            let parsed = element as! [String: Any]
                            self.data.append(parsed)
                        }
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            // 4: Stop the animation, here you have three options for the `animationStyle` property:
                            // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                            // .shake: when you want to reflect to the user that the task did not complete successfly
                            // .normal
                            button.stopAnimation(animationStyle: .expand, completion: {
                                self.performSegue(withIdentifier: "toMain", sender: nil)
                                
                            })
                        })
                    }
                }
            }
            
            
        })
    }


}
extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}

