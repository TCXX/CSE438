//
//  Pet.swift
//  Lab2
//
//  Created by XINYI on 2/2/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class Pet{
    
    // Pet type
    enum PetType {
        case dog
        case cat
        case bird
        case bunny
        case fish
    }
    
    // Range for food level and happiness
    let max:Double = 10
    let min:Double = 0
    
    
    // -----Data-----
    
    var name: String?
    var type: PetType
    
    // Current state
    private (set) var happiness: Double = 0
    private (set) var foodLevel: Double = 0
    
    // Care record
    private (set) var played: Int = 0
    private (set) var fed: Int = 0
    
    // Whether pet is already evolved
    private (set) var isEvolved = false
    
    // Most recent item applied to pet
    var recentItem: ShopItem? = nil
    
    
    // -----Behavior-----
    
    // Initiate variables.
    init(_name: String, _type: PetType){
        name = _name
        type = _type
    }
    
    // Increase food level by given amount.
    func feed(increment: Double = 1) -> (Bool) {
        foodLevel += increment
        fed = fed + 1
        if(foodLevel > max){
            foodLevel = max
        }
        return true
    }
    
    // Increase happiness by given amount.
    func collectHappiness (increment: Double = 1) -> (Bool) {
        happiness += increment
        if(happiness > max){
            happiness = max
        }
        return true
    }
    
    // Increase happiness and decrease food level by given amount.
    func play(increment: Double = 1) -> (Bool) {
        if(foodLevel - increment >= min){
            foodLevel -= increment
            happiness += increment
            played = played + 1
        } else {
            return false
        }
        
        if(happiness > max){
            happiness = max
        }
        return true
    }
    
    // Evolve a pet to special states (e. g. Pusheen).
    func evolve() -> (Bool) {
        if (happiness >= max) && (foodLevel >= max) && (isEvolved == false) {
            //Halve both values
            foodLevel = (foodLevel - min) * 0.5 + min
            happiness = (happiness - min) * 0.5 + min
            
            isEvolved = true
            return isEvolved
        } else {
            return false
        }
    }
}
