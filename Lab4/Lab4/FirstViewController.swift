//
//  FirstViewController.swift
//  Lab4
//
//  Created by XINYI on 2/25/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

//https://www.raywenderlich.com/113772/uisearchcontroller-tutorial
//http://www.omdbapi.com/?s=a&page=1

import UIKit

class FirstViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var theCollectionView: UICollectionView!
    @IBOutlet weak var theSearchBar: UISearchBar!
    @IBOutlet weak var theSpinner: UIActivityIndicatorView!
    
    var tableView: UITableView!
    
    // List of movies to display
    var theData: [Info] = []
    
    // Image cache once they apprear on screen
    var theImageCache: [String: UIImage?] = [:]
    
    // Storage
    let defaults = UserDefaults.standard
    
    // Number of posters per row
    let cellPerRow = 3
    
    func searchBar(_ searchBar: UISearchBar, textDidChange: String){
        // clean current list
        theData = []
        self.theCollectionView.reloadData()
        
        // pull data from API
        if (textDidChange != ""){
            self.theSpinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                self.theCollectionView.reloadData()
                self.fetchDataForCollectionView(str: textDidChange)
                self.cacheImages()
                
                DispatchQueue.main.async {
                    self.theCollectionView.reloadData()
                    self.theSpinner.stopAnimating()
                }
                
            }
        }
    }
    
    private func fetchDataForCollectionView(str: String) {
        theData = []
        
        // fix space among keywords
        let newStr = str.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil)
        
        // pull settings from local storage
        let ifPoster = defaults.bool(forKey: "ifPoster")
        let ifMovie = defaults.bool(forKey: "ifMovie")
        
        var movieStr: String = ""
        if (ifMovie) {
            movieStr = "&type=movie"
        }
        
        var numOfResults = defaults.integer(forKey: "numOfResults")
        if (numOfResults == 0) {
            numOfResults = 10
        }
        numOfResults *= cellPerRow
        
        // iterate until reach requirements or the end of search
        var i = 0
        while (theData.count < numOfResults) {
            i += 1
            let json = getJSON("http://www.omdbapi.com/?s="+newStr+"&page=" + String(i)+movieStr)
            
            // check for the end of search
            let ifReponse = json["Response"].boolValue
            if (ifReponse == false) {
                return
            }
            
            for result in json["Search"].arrayValue {
                // check the number of movies already get
                if (theData.count + 1 > numOfResults){
                    return
                }
                
                let name = result["Title"].stringValue
                let id = result["imdbID"].stringValue
                let url = result["Poster"].stringValue
                
                if (!ifPoster || url != "N/A") {
                    theData.append(Info(name: name, imdbID: id, url: url))
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
    
    // Number of columns
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return theData.count/cellPerRow
    }
    
    // Number per row
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellPerRow
        
    }
    
    // Create every cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.section * cellPerRow + indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        
        // image view
        let imageFrame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        let imageView = UIImageView()
        imageView.frame = imageFrame
        
        // label
        let label = UILabel()
        let labelSize: CGFloat = 40
        let labelFrame = CGRect(x: 0, y: cell.frame.height - labelSize, width: cell.frame.width, height: labelSize)
        label.frame = labelFrame
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13.0)
        
        // determine image
        let item: Info = theData[index]
        var image: UIImage? = UIImage(named: "none.jpg")
        if (theImageCache[item.imdbID] != nil) {
            if (theImageCache[item.imdbID]! != nil){
                image = theImageCache[item.imdbID]!!
            }
        }
        
        // set image and title
        label.text = item.name
        imageView.image = image
        label.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
        
        // add views to cell
        cell.addSubview(imageView)
        cell.addSubview(label)
        
        return cell
    }
    
    // Respond when cells are clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.section * cellPerRow + indexPath.row
        let item: Info = theData[index]
        
        //http://stackoverflow.com/questions/31561054/iboutlet-elements-come-out-nil-when-i-try-to-set-them-in-viewdidload
        let detailedVC = storyboard!.instantiateViewController(withIdentifier: "DetailedVC") as! Detailed
        
        // determine image
        let imageCache = theImageCache[item.imdbID]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //collection view delegate
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        
        //search bar delegate
        theSearchBar.delegate = self
        
        // manage collection view layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/CGFloat(cellPerRow)-10
        let height = width * 1.5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        theCollectionView.collectionViewLayout = layout
        
        // spinner
        theSpinner.hidesWhenStopped = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
