//
//  ViewController.swift
//  studio1
//
//  Created by XINYI on 1/23/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var theImage: UIImageView!
    
    @IBOutlet weak var theLabel: UILabel!

    @IBAction func sliderMoved(_ sender: UISlider) {
        //alpha ranges from 0 - 1, explicit conversion needed

        theLabel.text = String(format: "%.2f", sender.value)
        theImage.alpha = CGFloat(sender.value)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

