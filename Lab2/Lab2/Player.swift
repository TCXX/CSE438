//
//  Player.swift
//  Lab2
//
//  Created by XINYI on 2/4/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class Player{
    
    // Items available in shop
    static let itemList: [ShopItem] = [
        ShopItem(_name: "fish", _type: .food, _price: 10, food: 1.0, happiness: 0.5),
        ShopItem(_name: "donut", _type: .food, _price: 20, food: 2.5, happiness: 1.5),
        ShopItem(_name: "cookie", _type: .food, _price: 30, food: 4.0, happiness: 3.5),
        ShopItem(_name: "noodles", _type: .food, _price: 50, food: 6.5, happiness: 5.5)
        ]
    
    
    // -----Data-----
    
    // Virtual currency in game
    var coin: Int
    
    // Number of items for each type owned by player
    private (set) var bag: [Int]
    
    
    // -----Behavior-----
    
    // Initiate variables.
    init(_coin: Int = 100, items: [Int] = [0, 0, 0, 0]) {
        coin = _coin
        bag = items
    }
    
    // Call item's utility and update player's bag.
    func useItem(itemIndex: Int, pet: Pet) {
        if (itemIndex > bag.count){
            return //index out of range
        }
        if (bag[itemIndex] <= 0){
            return //no item
        }
        let isUsed = Player.itemList[itemIndex].use(pet: pet)
        if (isUsed){
            bag[itemIndex] = bag[itemIndex] - 1
        }
    }
    
    // If player can afford price, pay and obtain the item.
    func buyItem (itemIndex: Int) {
        if (itemIndex > bag.count){
            return //index out of range
        }
        if (Player.itemList[itemIndex].price > coin){
            return //no item
        }
        coin = coin - Player.itemList[itemIndex].price
        bag[itemIndex] = bag[itemIndex] + 1
    }
    
    // Increase player's coin by given amount.
    func redeem (increment: Int = 100) {
        coin = coin + increment
    }
}
