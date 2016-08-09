//
//  Garden.swift
//  Plants
//
//  Created by Юлия Хазиева on 25.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class Garden: SKScene {
    var toFactoryButton: MSButtonNode!
    var editButton: MSButtonNode!
    var position1:  SKSpriteNode!
    var position2:  SKSpriteNode!
    var position3:  SKSpriteNode!
    var position4:  SKSpriteNode!
    var position5:  SKSpriteNode!
    var chooseMenu: SKSpriteNode!
    var up: MSButtonNode!
    var down: MSButtonNode!
    var placelessPlants: [Plant] = []
    var currentPlacelessPlant = 0
    var plantToPlace = Plant()
    override func didMoveToView(view: SKView) {
        toFactoryButton = childNodeWithName("toFactoryButton") as! MSButtonNode
        position1 = childNodeWithName("position1") as! SKSpriteNode
        position2 = childNodeWithName("position2") as! SKSpriteNode
        position3 = childNodeWithName("position3") as! SKSpriteNode
        position4 = childNodeWithName("position4") as! SKSpriteNode
        position5 = childNodeWithName("position5") as! SKSpriteNode
        chooseMenu = childNodeWithName("chooseMenu") as! SKSpriteNode
        editButton = childNodeWithName("editButton") as! MSButtonNode
        up = childNodeWithName("//up") as! MSButtonNode
        down = childNodeWithName("//down") as! MSButtonNode
        
        position1.hidden = true
        position2.hidden = true
        position3.hidden = true
        position4.hidden = true
        position5.hidden = true

        
        for plant in GameManager.sharedInstance.unlockedPlants {
            if plant.gardenPosition == CGPoint(x: 0, y: 0) {
                placelessPlants.append(plant)
            } else {
                addChild(plant)
                plant.position = plant.gardenPosition
            }
        }
        
        toFactoryButton.selectedHandler = {
            print("game level:\(GameManager.sharedInstance.level)")
            GameManager.sharedInstance.restart = true
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.scaleMode = .AspectFit
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.presentScene(scene)
        }
        
        editButton.selectedHandler = {
            self.chooseMenu.runAction(SKAction.moveBy(CGVector(dx: -90, dy: 0), duration: 0.5))
            self.plantToPlace = self.placelessPlants[self.currentPlacelessPlant]
            self.addChild(self.plantToPlace)
            self.plantToPlace.position = CGPoint(x: 505, y: 160)
        }
        
        down.selectedHandler = {
            self.currentPlacelessPlant += 1
            self.plantToPlace = self.placelessPlants[self.currentPlacelessPlant]
        }
        
        up.selectedHandler = {
            self.currentPlacelessPlant -= 1
            self.plantToPlace = self.placelessPlants[self.currentPlacelessPlant]
        }
    
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        if currentPlacelessPlant < 0 {
            up.hidden = true
        } else {
            up.hidden = false
        }
        
        if self.placelessPlants.count > 1 {
            down.hidden = false
        } else {
            down.hidden = true
        }
    }
    
    
    
    
    
}