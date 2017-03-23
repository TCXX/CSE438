//
//  GameScene.swift
//  Lab2
//
//  Created by XINYI on 3/12/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

// Unlimited image rolling modified from
// http://stackoverflow.com/questions/26347559/endless-scrolling-repeating-background-in-spritekit-game-swift

import SpriteKit


class GameScene: SKScene {

    let background1 = SKSpriteNode(imageNamed: "summer.png")
    let background2 = SKSpriteNode(imageNamed: "summer.png")
    
    var snowNode = SKEmitterNode()
    var ifSnow = false
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    func switchImage (str: String) {
        background1.texture = SKTexture(imageNamed: str)
        background2.texture = SKTexture(imageNamed: str)
    }
    
    func switchSnow () {
        ifSnow = !ifSnow
        if (ifSnow) {
            self.addChild(snowNode)
        } else {
            snowNode.removeFromParent()
        }
    }
    
    private func setup() {
        // Configure images
        background1.size = CGSize(width: background1.size.width, height: frame.height)
        background1.anchorPoint = CGPoint(x: 0, y: 0)
        background1.position = CGPoint(x: 0, y: 0)
        background1.zPosition = 0
        self.addChild(background1)
        
        background2.size = CGSize(width: background2.size.width, height: frame.height)
        background2.anchorPoint = CGPoint(x: 0, y: 0)
        background2.position = CGPoint(x: background1.size.width - 2,y: 0)
        background2.zPosition = 0
        self.addChild(background2)
        
        // Add snows
        // Snow.sks and spark.png from
        // https://github.com/Noodlekim/AppWithSpriteKit
        let snowPath = Bundle.main.path(forResource: "Snow", ofType: "sks")
        snowNode = NSKeyedUnarchiver.unarchiveObject(withFile: snowPath!) as! SKEmitterNode
        
        snowNode.position = CGPoint(x: 0, y: 0)
        snowNode.particleScale = 0.09
    }
    
    override func update(_ currentTime: TimeInterval) {
        background1.position = CGPoint(x: background1.position.x-1, y: background1.position.y)
        background2.position = CGPoint(x: background2.position.x-1, y: background2.position.y)
        if(background1.position.x + background1.size.width < 0)
        {
            background1.position = CGPoint(x: background1.position.x + 2*background1.size.width - 2, y: background1.position.y)
        }
        if(background2.position.x + background2.size.width < 0)
        {
            background2.position = CGPoint(x: background2.position.x + 2*background2.size.width - 2, y: background2.position.y)
        }
    }
}
