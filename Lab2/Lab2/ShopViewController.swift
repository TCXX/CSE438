//
//  ShopViewController.swift
//  Lab2
//
//  Created by XINYI on 2/4/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        update()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function is modified from Passing data between ViewControllers
    // http://jamesleist.com/ios-swift-passing-data-between-viewcontrollers/
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Leave shopping page for main screen.
    @IBAction func bakcToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // -----Outlets-----
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var redeemButton: UIButton!
    
    @IBOutlet weak var itemView0: BagItemView!
    @IBOutlet weak var itemView1: BagItemView!
    @IBOutlet weak var itemView2: BagItemView!
    @IBOutlet weak var itemView3: BagItemView!
    
    @IBOutlet weak var buyButton1: UIButton!
    @IBOutlet weak var buyButton2: UIButton!
    @IBOutlet weak var buyButton3: UIButton!
    @IBOutlet weak var buyButton4: UIButton!
    
    
    // Current player, data passed from main view controller
    var player = Player()
    
    
    // -----Constants-----
    
    // Images of listed items
    let itemImages: [UIImage?] = [UIImage(named: "fish-1"),
                                  UIImage(named: "donut"),
                                  UIImage(named: "cookie"),
                                  UIImage(named: "cupcake")]
    
    
    // -----Functions-----
    
    // Inialize page with items' images.
    func setup() {
        // Safely pass images in
        itemView0.setImage(image: itemImages[0])
        itemView1.setImage(image: itemImages[1])
        itemView2.setImage(image: itemImages[2])
        itemView3.setImage(image: itemImages[3])
    }
    
    // Update display for player's coins and number of items.
    func update() {
        coinLabel.text = "Coin: " + String(player.coin)
        itemView0.value = player.bag[0]
        itemView1.value = player.bag[1]
        itemView2.value = player.bag[2]
        itemView3.value = player.bag[3]
    }
    
    // Redeem when button is pressed.
    @IBAction func redeemCoins(_ sender: Any) {
        player.redeem()
        update()
    }
    
    // Buy items when buttons are pressed.
    
    @IBAction func buyFish(_ sender: Any) {
        player.buyItem(itemIndex: 0)
        update()
    }
    
    @IBAction func buyDonut(_ sender: Any) {
        player.buyItem(itemIndex: 1)
        update()
    }
    
    @IBAction func buyCookie(_ sender: Any) {
        player.buyItem(itemIndex: 2)
        update()
    }
    
    @IBAction func buyCupcake(_ sender: Any) {
        player.buyItem(itemIndex: 3)
        update()
    }
    
    
}
