//
//  SecondViewController.swift
//  Lab4
//
//  Created by XINYI on 2/25/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

// cell for table view
class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var theLabel: UILabel!
}

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var theSpinner: UIActivityIndicatorView!
    
    // List of movies to display
    var theData: [Info] = []
    
    // Image cache once they apprear on screen
    var theImageCache: [String: UIImage?] = [:]
    
    // List of movies pulled from local storage
    var theFavorates: [String] = []
    
    // Storage
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshList()
    }
    
    // Pull list of favorates from local storage
    private func refreshList() {
        self.theSpinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.getData()
            self.cacheImages()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.theSpinner.stopAnimating()
            }
            
        }
    }
    
    // Get info for each movie in favorates by ID
    private func getData() {
        
        theFavorates = defaults.object(forKey: "favorates") as? [String] ?? [String]()
        
        theData = []
        for item in theFavorates {
            let json = getJSON("http://www.omdbapi.com/?i="+item+"&plot=short&r=json")
            
            let theURL = json["Poster"].stringValue
            let theTitle = json["Title"].stringValue
            let info = Info(name: theTitle, imdbID: item, url: theURL)
            
            theData.append(info)
            
        }
    }
    
    // Append images in theData
    private func cacheImages() {
        
        for item in theData {
            let url = URL(string: item.url)
            let id = item.imdbID
            
            var image: UIImage? = nil
            
            if (url != nil) {
                let data = try? Data(contentsOf: url!)
                if (data != nil){
                    image = UIImage(data: data!)
                    theImageCache.updateValue(image, forKey: id)
                }
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
    
    // Create every cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item: Info = theData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        var image: UIImage? = UIImage(named: "none.jpg")
        if (theImageCache[item.imdbID] != nil) {
            if (theImageCache[item.imdbID]! != nil){
                image = theImageCache[item.imdbID]!!
            }
        }
        
        cell.theLabel?.text = item.name
        cell.theImageView?.image = image
        
        return cell
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theData.count
        
    }
    
    // Respond when cells are clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item: Info = theData[indexPath.row]
        
        //http://stackoverflow.com/questions/31561054/iboutlet-elements-come-out-nil-when-i-try-to-set-them-in-viewdidload
        let detailedVC = storyboard!.instantiateViewController(withIdentifier: "DetailedVC") as! Detailed
        
        let imageCache = theImageCache[item.imdbID]
        
        // determine image
        var image: UIImage? = UIImage(named: "none.jpg")
        if (imageCache != nil){
            if (imageCache! != nil){
                image = theImageCache[item.imdbID]!!
            }
        }
        
        // push to view controller
        detailedVC.theId = item.imdbID
        detailedVC.theImage = image
        detailedVC.title = item.name
        
        navigationController?.pushViewController(detailedVC, animated: true)
        
    }
    
    // Add delete cell function
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Delete from list when clicked delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
    
            var array = defaults.object(forKey: "favorates") as? [String] ?? [String]()
            
            array.remove(at: indexPath.row)
            defaults.set(array, forKey: "favorates")
            
            refreshList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //delegates
        tableView.dataSource = self
        tableView.delegate = self
        
        // spinner
        self.theSpinner.hidesWhenStopped = true
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

