//
//  ThirdViewController.swift
//  Lab4
//
//  Created by XINYI on 3/5/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    // Storage
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var posterSwitch: UISwitch!
    @IBOutlet weak var movieSwitch: UISwitch!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var theLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Only those with posters
        let ifPoster = defaults.bool(forKey: "ifPoster")
        posterSwitch.setOn(ifPoster, animated: false)
        
        // Only those that are movies
        let ifMovie = defaults.bool(forKey: "ifMovie")
        movieSwitch.setOn(ifMovie, animated: false)

        // Number of rows per time
        var numOfResults = defaults.integer(forKey: "numOfResults")
        if (numOfResults == 0) {
            numOfResults = 10
        }
        numberTextField.text = String(numOfResults)
        
        // Hide label
        theLabel.alpha = 0.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func posterChanged(_ sender: Any) {
        saveSettings()
    }

    @IBAction func movieChanged(_ sender: Any) {
        saveSettings()
    }
    
    @IBAction func rowChanged(_ sender: Any) {
        saveSettings()
    }
    
    private func saveSettings() {
        
        // Only those with posters
        defaults.set(posterSwitch.isOn, forKey: "ifPoster")
        
        // Only those that are movies
        defaults.set(movieSwitch.isOn, forKey: "ifMovie")
    
        // Number of results
        let str = numberTextField.text
        var num = 10
        
        if (str != nil) {
            let db = Int(str!)
            if (db != nil) {
                if (db! <= 100) {
                    num = db!
                } else {
                    num = 100
                }
            }
        }
        defaults.set(num, forKey: "numOfResults")
        
        // update display
        numberTextField.text = String(num)
        theLabel.alpha = 1.0
    
    }
    
}
