//
//  ViewController.swift
//  Lab2
//
//  Created by XINYI on 2/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    // Background animated scene
    let scene = GameScene(fileNamed:"GameScene")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updatePets(pet: petList[0])
        setBagDisplay()
        updateBagDisplay()
        
        scene?.scaleMode = .aspectFill
        scene?.size = bgView.bounds.size
        
        bgView.presentScene(scene)
        
        scene?.switchImage(str: "summer.png")
        updateSeason()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update display for number of items that player has.
        updateBagDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare for segue, consulted
    // http://stackoverflow.com/questions/39563828/swift-3-preparefor-segue-function-broken
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToShop") {
            // Deal with navigation controller, consulted
            // https://www.andrewcbancroft.com/2015/06/02/access-sub-controllers-from-a-uinavigationcontroller-in-swift/
            
            let nvc = segue.destination as! UINavigationController
            let svc = nvc.viewControllers[0] as! ShopViewController
            
            // Pass user data
            svc.player = currentPlayer
        }
    }
    
    
    // -----Outlets-----
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var evolveButton: UIButton!
    
    @IBOutlet weak var happinessBar: DisplayView!
    @IBOutlet weak var foodLevelBar: DisplayView!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIView!
    @IBOutlet weak var recentImageView: UIImageView!
    
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var fedLabel: UILabel!
    
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var birdButton: UIButton!
    @IBOutlet weak var bunnyButton: UIButton!
    @IBOutlet weak var fishButton: UIButton!
    
    @IBOutlet weak var itemView0: BagItemView!
    @IBOutlet weak var itemView1: BagItemView!
    @IBOutlet weak var itemView2: BagItemView!
    @IBOutlet weak var itemView3: BagItemView!
    
    @IBOutlet weak var useButton0: UIButton!
    @IBOutlet weak var useButton1: UIButton!
    @IBOutlet weak var useButton2: UIButton!
    @IBOutlet weak var useButton3: UIButton!
    
    @IBOutlet weak var bgView: SKView!
    
    // -----States-----
    
    // Pet that is displaying on main screen
    var currentPet: Pet!{
        didSet{
            updateBars(animated:false)
        }
    }
    
    // Current player
    var currentPlayer: Player = Player(_coin: 100, items: [3, 0, 0, 0])
    
    // Current season
    var currentSeason = 0 //winter=1, summer=0
    
    
    // -----Constants-----
    
    // All pets that player has
    let petList: [Pet] = [Pet(_name: "cat", _type: .cat),
                          Pet(_name: "dog", _type: .dog),
                          Pet(_name: "bird", _type: .bird),
                          Pet(_name: "bunny", _type: .bunny),
                          Pet(_name: "fish", _type: .fish)]
    
    // Colors for pets
    let colorDics: [Pet.PetType: UIColor] = [
        .cat: UIColor(red: 186/255, green: 238/255, blue: 238/255, alpha: 1),
        .dog: UIColor(red: 255/255, green: 186/255, blue: 186/255, alpha: 1),
        .bird: UIColor(red: 249/255, green: 255/255, blue: 186/255, alpha: 1),
        .bunny: UIColor(red: 188/255, green: 255/255, blue: 186/255, alpha: 1),
        .fish: UIColor(red: 237/255, green: 186/255, blue: 255/255, alpha: 1),]
    
    // Images for pets
    let imageDics: [Pet.PetType: UIImage?] = [
        .cat: UIImage(named: "Cat"),
        .dog: UIImage(named: "Dog"),
        .bird: UIImage(named: "Bird"),
        .bunny: UIImage(named: "Bunny"),
        .fish: UIImage(named: "Fish")]
    
    // Images for items
    let itemImages: [UIImage?] = [UIImage(named: "fish-1"),
                                  UIImage(named: "donut"),
                                  UIImage(named: "cookie"),
                                  UIImage(named: "cupcake")]
    
    // Images for evolved animals
    let pusheenImages: [UIImage?] = [UIImage(named: "pusheen-fish"),
                                     UIImage(named: "pusheen-donut"),
                                     UIImage(named: "pusheen-cookie"),
                                     UIImage(named: "pusheen-cupcake")]
    let defaultPusheenImage: UIImage? = UIImage(named: "pusheen-sad")
    
    // Colors for different seasons
    let summerColor = UIColor(red: 128/255, green: 214/255, blue: 89/255, alpha: 1)
    let winterColor = UIColor(red: 218/255, green: 226/255, blue: 237/255, alpha: 1)
    
    
    // -----Functions-----
    
    // Play current pet if allowed.
    @IBAction func petPlay(_ sender: Any) {
        if(currentPet.play()){
            updateBars(animated: true)
        }
    }
    
    // Feed current pet if allowed.
    @IBAction func petFeed(_ sender: Any) {
        if(currentPet.feed()){
            updateBars(animated: true)
        }
    }
    
    // Evolve current pet if allowed.
    @IBAction func petEvolve(_ sender: Any) {
        let isEvolved = currentPet.evolve()
        if (isEvolved) {
            updateBars(animated: true)
            updateImages()
        }
    }
    
    // Update display for bar values and button states.
    func updateBars(animated: Bool){
        let happinessValue = CGFloat((currentPet.happiness - currentPet.min) / (currentPet.max - currentPet.min))
        let foodLevelValue = CGFloat((currentPet.foodLevel - currentPet.min) / (currentPet.max - currentPet.min))
        if (animated){
            happinessBar.animateValue(to: happinessValue)
            foodLevelBar.animateValue(to: foodLevelValue)
        }else{
            happinessBar.value = happinessValue
            foodLevelBar.value = foodLevelValue
        }
        playedLabel.text = "played: " + String(currentPet.played)
        fedLabel.text = "fed: " + String(currentPet.fed)
        
        if (currentPet.foodLevel > 0) {
            playButton.isEnabled = true
        } else {
            playButton.isEnabled = false
        }
        
        if (currentPet.foodLevel + currentPet.happiness >= 2*currentPet.max)
            && (currentPet.isEvolved == false) {
            evolveButton.isEnabled = true
        } else {
            evolveButton.isEnabled = false
        }
    }
    
    // Switch to given pet and update display.
    func updatePets(pet: Pet) {
        currentPet = pet
        
        let themeColor = colorDics[currentPet.type]
        var color:UIColor
        if (themeColor !== nil){
            color = themeColor!
        } else {
            color = UIColor.white
        }
        
        happinessBar.color = color
        foodLevelBar.color = color
        updateImages()
    }
    
    // Update pet image and recent item image.
    func updateImages() {
        var pusheenImage: UIImage? = defaultPusheenImage
        if (currentPet.recentItem == nil) {
            recentImageView.image = nil
        } else {
            for i in 0...3 {
                if (currentPet.recentItem == Player.itemList[i]) {
                    recentImageView.image = itemImages[i]
                    pusheenImage = pusheenImages[i]
                }
            }
        }
        if (currentPet.isEvolved == false) {
            if (imageDics[currentPet.type] != nil) {
                petImageView.image = imageDics[currentPet.type]!
            }
            recentImageView.alpha = 1
        } else {
            petImageView.image = pusheenImage
            recentImageView.alpha = 0
        }
    }
    
    // Update display for numbers of items that player has.
    func updateBagDisplay(){
        itemView0.value = currentPlayer.bag[0]
        itemView1.value = currentPlayer.bag[1]
        itemView2.value = currentPlayer.bag[2]
        itemView3.value = currentPlayer.bag[3]
    }
    
    // Initialize images for items.
    func setBagDisplay() {
        itemView0.setImage(image: itemImages[0])
        itemView1.setImage(image: itemImages[1])
        itemView2.setImage(image: itemImages[2])
        itemView3.setImage(image: itemImages[3])
    }

    
    // Change to corresponding pets when buttons are pressed.
    
    @IBAction func changeToCat(_ sender: Any) {
        updatePets(pet: petList[0])
    }
    
    @IBAction func changeToDog(_ sender: Any) {
        updatePets(pet: petList[1])
    }
    
    @IBAction func changeToBird(_ sender: Any) {
        updatePets(pet: petList[2])
    }
    
    @IBAction func changeToBunny(_ sender: Any) {
        updatePets(pet: petList[3])
    }
    
    @IBAction func changeToFish(_ sender: Any) {
        updatePets(pet: petList[4])
    }
    
    
    // Change season
    @IBAction func changeSeason(_ sender: Any) {
        currentSeason = (currentSeason + 1) % 2
        updateSeason()
        scene?.switchSnow()
    }
    
    func updateSeason() {
        if (currentSeason == 0) {
            bgImageView.backgroundColor = summerColor
            scene?.switchImage(str: "summer.png")
        } else {
            bgImageView.backgroundColor = winterColor
            scene?.switchImage(str: "winter.png")
        }
    }
    
    // Use corresponding items when buttons are pressed.
    
    @IBAction func useFish(_ sender: Any) {
        currentPlayer.useItem(itemIndex: 0, pet: currentPet)
        updateBars(animated: true)
        updateBagDisplay()
        updateImages()
    }
    
    @IBAction func useDonut(_ sender: Any) {
        currentPlayer.useItem(itemIndex: 1, pet: currentPet)
        updateBars(animated: true)
        updateBagDisplay()
        updateImages()
    }
    
    @IBAction func useCookie(_ sender: Any) {
        currentPlayer.useItem(itemIndex: 2, pet: currentPet)
        updateBars(animated: true)
        updateBagDisplay()
        updateImages()
    }
    
    @IBAction func useCupcake(_ sender: Any) {
        currentPlayer.useItem(itemIndex: 3, pet: currentPet)
        updateBars(animated: true)
        updateBagDisplay()
        updateImages()
    }
    
}





