//
//  Detailed.swift
//  AwesomeDemo
//
//  Created by Todd Sproull on 2/22/17.
//  Copyright © 2017 Todd Sproull. All rights reserved.
//

import UIKit

class Detailed: UIViewController {
    
    // Movie info
    var theImage: UIImage!
    var theId: String!
    var theURL: String!
    var theTitle: String!
    
    // Storage
    let defaults = UserDefaults.standard
    
    // Button titles
    let buttonText1 = "Add to Favorates"
    let buttonText2 = "Remove From List"
    
    
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var theImageView: UIImageView!
    
    @IBOutlet weak var thePlot: UILabel!
    @IBOutlet weak var theGenre: UILabel!
    @IBOutlet weak var theYear: UILabel!
    @IBOutlet weak var theCountry: UILabel!
    @IBOutlet weak var theRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theImageView.image = theImage
        
        // Do any additional setup after loading the view.
        
        theButton.layer.borderWidth = 1
        theButton.layer.borderColor = theButton.currentTitleColor.cgColor
        theButton.layer.cornerRadius = 5.0
        
        thePlot.numberOfLines = 0
        
        // request JSON
        let json = getJSON("http://www.omdbapi.com/?i="+theId+"&plot=short&r=json")
        
        // parse movie info
        theRating.text = "Rated: " + json["Rated"].stringValue
        theYear.text = "Year: " + json["Year"].stringValue
        theGenre.text = "Genre: " + json["Genre"].stringValue
        theCountry.text = "Country: " + json["Country"].stringValue
        theURL = json["Poster"].stringValue
        theTitle = json["Title"].stringValue
        
        let plot = json["Plot"].stringValue
        if (plot != "N/A") {
            thePlot.text = plot
        } else {
            thePlot.text = " "
        }
        
        // update button title
        updateButtonText()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateButtonText()
    }
    
    // Update button title based on whether movie already in list
    private func updateButtonText () {
        let array = defaults.object(forKey: "favorates") as? [String] ?? [String]()
        
        theButton.setTitle(buttonText1,for: .normal)
        for id in array {
            if (id == theId) {
                theButton.setTitle(buttonText2,for: .normal)
            }
        }
    }
    
    // Helper function for Swifty JSON
    private func getJSON(_ url: String) -> JSON {
        
        if let url = URL(string: url){
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                return json
            } else {
                return JSON.null
            }
        } else {
            return JSON.null
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        // pull from local storage
        var array = defaults.object(forKey: "favorates") as? [String] ?? [String]()
        
        theButton.setTitle(buttonText2,for: .normal)
        
        if (array.count > 0) {
            for i in 0...array.count-1 {
                if (array[i] == theId) {
                    // delete from list
                    theButton.setTitle(buttonText1,for: .normal)
                    array.remove(at: i)
                    defaults.set(array, forKey: "favorates")
                    return
                }
            }
        }
        
        // add to favorates
        array.append(theId)
        defaults.set(array, forKey: "favorates")
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
