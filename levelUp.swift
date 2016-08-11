//
//  levelUp.swift
//  Plants
//
//  Created by Юлия Хазиева on 21.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class levelUp: SKScene {

    var newLevel: SKLabelNode!
    var toStoreButton: MSButtonNode!
    var toFactoryButton: MSButtonNode!
    var plantName: SKLabelNode!
    var youUnlocked: SKLabelNode!
    var gift: MSButtonNode!
    var normalSquare: SKSpriteNode!
    var theEndSquare: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        
        newLevel = childNodeWithName("//newLevel") as! SKLabelNode
        toStoreButton = childNodeWithName("//toStoreButton") as! MSButtonNode
        toFactoryButton = childNodeWithName("//toFactoryButton") as! MSButtonNode
        plantName = childNodeWithName("//plantName") as! SKLabelNode
        youUnlocked = childNodeWithName("//youUnlocked") as! SKLabelNode
        gift = childNodeWithName("//gift") as! MSButtonNode
        normalSquare = childNodeWithName("normalSquare") as! SKSpriteNode
        theEndSquare = childNodeWithName("theEndSquare") as! SKSpriteNode
        
        gift.hidden = true
        plantName.hidden = true
        theEndSquare.hidden = true
        
        gift.selectedHandler = {
            self.unlockAPlant()
            self.plantName.hidden = false
            self.gift.hidden = true
        }
        
        if GameManager.sharedInstance.level == 1 {
            youUnlocked.hidden = true
        } else {
            youUnlocked.hidden = false
        }
        newLevel.text = String(GameManager.sharedInstance.level)
        
        toFactoryButton.selectedHandler = {
            print("game level:\(GameManager.sharedInstance.level)")
            GameManager.sharedInstance.restart = true
            let skView = self.view as SKView!
            if GameManager.sharedInstance.level < 7 {
                let scene = GameScene(fileNamed:"GameScene") as GameScene!
                scene.scaleMode = .AspectFit
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.presentScene(scene)
            } else {
                let scene = GameScene(fileNamed:"threeConveyers") as GameScene!
                scene.scaleMode = .AspectFit
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.presentScene(scene)
            }
        }

        
        switch GameManager.sharedInstance.level {
        case 2:
            let newStage = SKSpriteNode(imageNamed: "NEW SHOWER")
            newStage.position = CGPoint(x: 276, y: 135)
            addChild(newStage)
            plantName.text = "Water"
            plantName.hidden = false
        case 3:
            gift.hidden = false
        case 4:
            let newStage = SKSpriteNode(imageNamed: "пппппп")
            newStage.position = CGPoint(x: 276, y: 135)
            newStage.setScale(0.2)
            addChild(newStage)
            plantName.text = "Fertilizer"
            plantName.hidden = false
        case 5:
            gift.hidden = false
        case 6:
            gift.hidden = false
        case 7:
            break
            
//        case 8:
//            unlockAPlant()
//        case 9:
//            // unlock stage
//        case 10:
//            // unlock stage
//        case 11:
//            unlockAPlant()
        default: break
            //todo: morelevel coming soon
        }
    }
    
    
    func unlockAPlant() {
        let randomNumber = (Int)(arc4random_uniform((UInt32)(GameManager.sharedInstance.lockedPlants.count)))
        let newPlant = GameManager.sharedInstance.lockedPlants[randomNumber]
        GameManager.sharedInstance.lockedPlants.removeAtIndex(randomNumber)
        GameManager.sharedInstance.unlockedPlants.append(newPlant)
        GameManager.sharedInstance.saveData()
        switch newPlant {
        case let plant as aloe:
            var newPlant = aloe(texture: SKTexture(imageNamed: "16 aloe"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "16 aloe").size())
            newPlant.position = CGPoint(x: 276, y: 135)
            print("i am aloe")
            self.addChild(newPlant)
        case let plant as englishIvy:
            let newPlant = englishIvy(texture: SKTexture(imageNamed: "56 ivy"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "56 ivy").size())
            newPlant.position = CGPoint(x: 276, y: 135)
            print("i am english ivy")
            self.addChild(newPlant)
        case let plant as jadePlant:
            let newPlant = jadePlant(texture: SKTexture(imageNamed: "46 money tree"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "46 money tree").size())
            newPlant.position = CGPoint(x: 276, y: 135)
            print("i am jadeplant")
            self.addChild(newPlant)
        case let plant as rubberTree:
            let newPlant = rubberTree(texture: SKTexture(imageNamed: "36 ficus"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "36 ficus").size())
            newPlant.position = CGPoint(x: 276, y: 135)
            print("i am a rubbertree")
            self.addChild(newPlant)
        case let plant as cereusPeruvianus:
            let newPlant = cereusPeruvianus(texture: SKTexture(imageNamed: "66 cereus"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "66 cereus").size())
            newPlant.position = CGPoint(x: 276, y: 135)
            print("i am a rubbertree")
            self.addChild(newPlant)
        default:
            print("something went wrong")
        }
        plantName.text = newPlant.kindOfPlant
    }
    
    func unlockAStage() {
        
    }
}