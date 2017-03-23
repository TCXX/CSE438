//
//  ShopItem.swift
//  Lab2
//
//  Created by XINYI on 2/4/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class ShopItem: Equatable {
    
    // Item category
    enum itemType{
        case food
        case toy
        case special
    }
    
    
    // -----Data-----
    
    private (set) var name: String
    private (set) var type: itemType
    private (set) var price: Int
    
    // Promised effects when using this item
    private (set) var foodLevelIncrement: Double
    private (set) var happinessIncrement: Double
    
    
    // -----Behavior-----
    
    // Initiate variables.
    init(_name: String, _type: itemType, _price: Int, food: Double, happiness: Double) {
        name = _name
        type = _type
        price = _price
        if (price < 0){
            price = 0
        }
        
        foodLevelIncrement = food
        happinessIncrement = happiness
    }
    
    // Return whether two items are identical, name excluded.
    // Comparing custom objects, consulted
    // http://stackoverflow.com/questions/30105272/compare-two-instances-of-an-object-in-swift
    public static func ==(lhs: ShopItem, rhs: ShopItem) -> (Bool) {
        return
            lhs.type == rhs.type &&
                lhs.price == rhs.price &&
                lhs.foodLevelIncrement == rhs.foodLevelIncrement &&
                lhs.happinessIncrement == rhs.happinessIncrement
    }
    
    // Perform promised effects on given pet and return whether used.
    func use(pet: Pet) -> Bool {
        let isFed = pet.feed(increment: foodLevelIncrement)
        let isPlayed = pet.collectHappiness(increment: happinessIncrement)
        
        if (isFed && isPlayed) {
            pet.recentItem = self
            return true
        }
        
        return false
    }

}
