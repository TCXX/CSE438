//
//  ColorButton.swift
//  Lab3
//
//  Created by XINYI on 2/11/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class ColorButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        //round the corners
        if (self.layer.frame.width <= self.layer.frame.height){
            self.layer.cornerRadius = self.layer.frame.width/2
        } else {
            self.layer.cornerRadius = self.layer.frame.height/2
        }
    }

}
