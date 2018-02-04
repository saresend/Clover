
//
//  GradientView.swift
//  DevNews
//
//  Created by Samuel Resendez on 2/4/18.
//  Copyright © 2018 Samuel Resendez. All rights reserved.
//

import UIKit

class GradientView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(hex: 0x6F35CE), UIColor(hex: 0xA13084)]
    }

}

