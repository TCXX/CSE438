//
//  BagItemView.swift
//  Lab2
//
//  Created by XINYI on 2/4/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class BagItemView: UIView {
    
    // Number of items wished to display at corner
    // Bonded with text field display
    public var value: Int {
        get{
            let intLabel: Int? = Int(label.text!)
            if (intLabel == nil){
                return 0
            }
            return intLabel!
        }
        set(newValue) {
            label.text = String (newValue)
            if (value == 0){
                imageView.alpha = 0.5
            }else{
                imageView.alpha = 1
            }
        }
    }
    
    // Ratio of display size of image to that of outer square
    let imageRatio: CGFloat = 0.5
    
    // Height and width of label
    let labelSize: CGFloat = 30
    
    var label: UILabel = UILabel()
    var imageView: UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        value = 0
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor(white: 1, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5.0

        let imageWidth: CGFloat = self.frame.width * imageRatio
        let imageHeight: CGFloat = self.frame.height * imageRatio
        let imageFrame = CGRect(x: (self.frame.width - imageWidth) * imageRatio,
                                y: (self.frame.height - imageHeight) * imageRatio,
                                width: imageWidth, height: imageHeight)
        imageView.frame = imageFrame
        imageView.alpha = 0.5
        
        label.text = "0"
        let labelFrame = CGRect(x: self.frame.width - labelSize,
                             y: self.frame.height - labelSize,
                             width: labelSize, height: labelSize)
        label.frame = labelFrame
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.red
        
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
    // Display given image
    func setImage(image: UIImage?){
        imageView.image = image
    }
    
}
