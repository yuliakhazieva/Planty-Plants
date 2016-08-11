
//
//  GameScene.swift
//  Plants
//
//  Created by Юлия Хазиева on 11.07.16.
//  Copyright (c) 2016 Юлия Хазиева. All rights reserved.


//  todo: garden
//  todo: 3 conveyers
//  todo: store
//  todo: random falling
//  todo: random spawn
//  todo: gameover sound
//  todo: playbuttonsound
//  todo: levelup sound


import Mixpanel
import SpriteKit

class oneConveyerbelt: SKScene, SKPhysicsContactDelegate {
    
    /*constants*/
    let fixedDelta: CFTimeInterval = 1.0/60.0
    let disappear = SKAction.removeFromParent()
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    
    /*variables*/
    /*code connections*/
    var coinsPic: SKSpriteNode!
    var conveyerLevel1: SKNode!
    var conveyerLevel2: SKNode!
    var lift: SKSpriteNode!
    var seedEmitter: MSButtonNode!
    var seed: SKSpriteNode!
    var waterEmitter: MSButtonNode!
    var water: SKSpriteNode!
   
    var progressBar: SKSpriteNode!
    var levelLabel: SKLabelNode!
    var comboLabel: SKLabelNode!
    var moneyLabel: SKLabelNode!
    var pauseButton: MSButtonNode!
    var resumeButton: MSButtonNode!
    var levelUpNotification: SKLabelNode!
    var settingsButton: MSButtonNode!
    var restartButton: MSButtonNode!
    var pauseScreen: SKSpriteNode!
    var hand: SKSpriteNode!
    var pauseFog: SKSpriteNode!
    var plantsOutOf: SKLabelNode!
    var life1: SKSpriteNode!
    var life2: SKSpriteNode!
    var life3: SKSpriteNode!
    var gameOverSquare: SKSpriteNode!
    var tryAgainButton: MSButtonNode!
    var playButton: MSButtonNode!
    var creditsButton: MSButtonNode!
    var creditsSquare: SKSpriteNode!
    var levelUseless: SKLabelNode!
    var playSquare: SKSpriteNode!
    //  var seedContact: SKSpriteNode!

    var waterContact: SKSpriteNode!
   
    var seedContact: SKSpriteNode!
    var areYouSureSquare: SKSpriteNode!
    var yes: MSButtonNode!
    var no: MSButtonNode!
    var settingsSquare: SKSpriteNode!
    var onOff: MSButtonNode!
    var onLabel: SKLabelNode!
    var offLabel: SKLabelNode!
    var FAQButton: MSButtonNode!
    var FAQsquare: SKSpriteNode!
    
    /*timers*/
    var waterTimer = 2.0
    var lightTimer = 2.0
    var fertelizerTimer = 2.0
    var seedTimer = 2.0
    var liftTimer = 2.0
    var spawnEvery = 0.0
    var spawnTimer = 6.0
    var pulseWaterTimer = 4.0
    var pulseLightTimer = 4.0
    var pulseFertilizerTimer = 4.0
    var pulseSeedTimer = 4.0
    /*plant instances*/
    // var cereusPeruvianusInstance: cereusPeruvianus!
    var hensAndChicksInstance: hensAndChicks!
    
    /*arrays*/
    var plantsInTheScene: [Plant] = []
    var unlockedPlants: [Plant] = []
    var levelSpecifications: [[Int]] = []
    
    /*other*/
    var coins = 0
    var userLevel = 0
    var gameState: GameState = .play
    var plantsCompleted = 0
    var plantsDropped = 0
    var plantsNeeded = 0
    var lives = 0
    var difficulty = 1
    var stagesCount = 4
    var soundOn = 1
    var liftmoving = false
    
    override func didMoveToView(view: SKView) {
        
        
        
        userLevel = GameManager.sharedInstance.level
        if userLevel > 6 {
            let scene = threeConveyers(fileNamed:"threeConveyers") as threeConveyers!
            let skView = self.view as SKView!
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
        
        /*code connections*/
        levelUpNotification = childNodeWithName("levelUpNotification") as! SKLabelNode
        levelUseless = childNodeWithName("levelUseless") as! SKLabelNode
        progressBar = childNodeWithName("progressBar") as! SKSpriteNode
        levelLabel = childNodeWithName("levelLabel") as! SKLabelNode
        moneyLabel = childNodeWithName("moneyLabel") as! SKLabelNode
        pauseButton = childNodeWithName("//pauseButton") as! MSButtonNode
        resumeButton = childNodeWithName("//resumeButton") as! MSButtonNode
        settingsButton = childNodeWithName("//settingsButton") as! MSButtonNode
        restartButton = childNodeWithName("//restartButton") as! MSButtonNode
        creditsButton = childNodeWithName("//creditsButton") as! MSButtonNode
        conveyerLevel1 = childNodeWithName("conveyerLevel1")
        conveyerLevel2 = childNodeWithName("conveyerLevel2")
        lift = childNodeWithName("lift") as! SKSpriteNode
        seedEmitter = childNodeWithName("seedEmitter") as! MSButtonNode
        seed = childNodeWithName("seed") as! SKSpriteNode
        waterEmitter = childNodeWithName("waterEmitter") as! MSButtonNode
        water = childNodeWithName("water") as! SKSpriteNode
        pauseScreen = childNodeWithName("pauseScreen") as! SKSpriteNode
        hand = childNodeWithName("hand") as! SKSpriteNode
        pauseFog = childNodeWithName("pauseFog") as! SKSpriteNode
        plantsOutOf = childNodeWithName("plantsOutOf") as! SKLabelNode
        life1 = childNodeWithName("life1") as! SKSpriteNode
        life2 = childNodeWithName("life2") as! SKSpriteNode
        life3 = childNodeWithName("life3") as! SKSpriteNode
        tryAgainButton = childNodeWithName("tryAgainButton") as! MSButtonNode
        gameOverSquare = childNodeWithName("gameOverSquare") as! SKSpriteNode
        playButton = childNodeWithName("playButton") as! MSButtonNode
        creditsSquare = childNodeWithName("creditsSquare") as! SKSpriteNode
        playSquare = childNodeWithName("playSquare") as! SKSpriteNode
        waterContact = childNodeWithName("waterContact") as! SKSpriteNode
        seedContact = childNodeWithName("seedContact") as! SKSpriteNode
        areYouSureSquare = childNodeWithName("areYouSureSquare") as! SKSpriteNode
        yes = childNodeWithName("//yes") as! MSButtonNode
        no = childNodeWithName("//no") as! MSButtonNode
        settingsSquare = childNodeWithName("settingsSquare") as! SKSpriteNode
        onOff = childNodeWithName("//onOff") as! MSButtonNode
        onLabel = childNodeWithName("//onLabel") as! SKLabelNode
        offLabel = childNodeWithName("//offLabel") as! SKLabelNode
        coinsPic = childNodeWithName("//coinsPic") as! SKSpriteNode
        FAQButton = childNodeWithName("//FAQButton") as! MSButtonNode
        FAQsquare = childNodeWithName("FAQSquare") as! SKSpriteNode
        
        self.levelUpNotification.hidden = true
        
        soundOn = GameManager.sharedInstance.soundOn
        
        if soundOn == 0 {
            onOff.position.x = 35.056999206543
        }
        areYouSureSquare.hidden = true
        settingsSquare.hidden = true
        FAQsquare.hidden = true
        
        self.pauseFog.hidden = false
        self.pauseFog.position = CGPoint(x: 286.748, y: 160.15)
        
        if GameManager.sharedInstance.restart == true {
            self.FAQsquare.hidden = true
            pauseFog.hidden = true
            gameState = .play
            if userLevel == 0 {
                gameState = .tutorial
            }
            playButton.hidden = true
            playSquare.hidden = true
        }
        physicsWorld.contactDelegate = self
        
        var ind = 0
        for plant in GameManager.sharedInstance.unlockedPlants {
            unlockedPlants.append(GameManager.sharedInstance.unlockedPlants[ind])
            ind += 1
        }
        
        /*starting states*/
        

        water.removeFromParent()
        seed.removeFromParent()
        
        
        gameOverSquare.hidden = true
        tryAgainButton.hidden = true
        creditsSquare.hidden = true

        

        
        settingsButton.selectedHandler = {
            self.settingsSquare.hidden = false
            self.areYouSureSquare.hidden = true
            self.FAQsquare.hidden = true
            self.creditsSquare.hidden = true
            
        }
        
        FAQButton.selectedHandler = {
            self.settingsSquare.hidden = true
            self.areYouSureSquare.hidden = true
            self.creditsSquare.hidden = true
            self.FAQsquare.hidden = false
        }
        
        onOff.selectedHandler = {
            if self.soundOn == 1 {
                self.soundOn = 0
            } else {
                self.soundOn = 1
            }
            if self.onOff.position.x < 9.0 {
                self.onOff.runAction(SKAction.moveToX(35.057, duration: 0.3))
            } else {
                self.onOff.runAction(SKAction.moveToX(8.173, duration: 0.3))
            }
            GameManager.sharedInstance.soundOn = self.soundOn
            GameManager.sharedInstance.saveData()
        }
        
        /*stage actions*/
        seedEmitter.selectedHandler = {
            if self.seedTimer > 1 {
                if self.soundOn == 1 {
                    self.runAction(SKAction.playSoundFileNamed("seed click", waitForCompletion: false))
                }
                if self.userLevel == 0 {
                    
                    self.pauseFog.hidden = true
                    self.seedEmitter.zPosition = 0
                }
                self.seedTimer = 0.0
                
                self.addChild(self.seed)
                self.seed.position = CGPoint(x: 397, y: 248)
                self.seed.hidden = false
                let fall = SKAction.moveBy(CGVector(dx: 0, dy: -100), duration: 1)
                self.seed.runAction(fall)
            }
        }
        
        waterEmitter.selectedHandler = {
            
            
          
                self.pauseFog.hidden = true
                self.waterEmitter.zPosition = 1
            
        
            /* Add particles to scene */
      
            if self.waterTimer > 1.5 {
                let particles = SKEmitterNode(fileNamed: "showerEffect")!
                
                /* Convert node location (currently inside Level 1, to scene space) */
                particles.position = CGPoint(x: 225, y: 246)
                
                /* Restrict total particles to reduce runtime of particle */
                particles.numParticlesToEmit = 700
                particles.particleLifetime = particles.particleLifetime + 0.05
                self.addChild(particles)
                if self.soundOn == 1 {
                    self.runAction(SKAction.playSoundFileNamed("water", waitForCompletion: false))
                }
                self.waterTimer = 0.0
                self.addChild(self.water)
                //     self.water.zPosition = 1
            }
        }
        
    
        
        pauseButton.selectedHandler = {
            if self.gameState != .pause {
                self.pauseScreen.runAction(SKAction.moveBy(CGVector(dx: -90, dy: 0), duration: 0.5))
                self.gameState = .pause
                for plant in self.plantsInTheScene {
                    plant.physicsBody?.pinned = true
                }
                self.pauseFog.hidden = false
            }
        }
        
        resumeButton.selectedHandler = {
            self.FAQsquare.hidden = true
            self.settingsSquare.hidden = true
            self.creditsSquare.hidden = true
            self.areYouSureSquare.hidden = true
            for plant in self.plantsInTheScene {
                plant.physicsBody?.pinned = false
            }
            self.pauseFog.hidden = true
            self.pauseScreen.runAction(SKAction.moveBy(CGVector(dx: 90, dy: 0), duration: 0.5))
            self.gameState = .play
            if self.userLevel == 0 {
                self.gameState = .tutorial
            }
        }
        
        restartButton.selectedHandler = {
            self.FAQsquare.hidden = true
            self.areYouSureSquare.hidden = false
            self.settingsSquare.hidden = true
            self.creditsSquare.hidden = true
        }
        no.selectedHandler = {
            self.areYouSureSquare.hidden = true
        }
        yes.selectedHandler = {
            GameManager.sharedInstance.restart = true
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
            self.pauseScreen.hidden = true
            
            if self.userLevel == 0 {
                self.gameState = .tutorial
            } else {
                self.gameState = .play
            }
            
        }
        creditsButton.selectedHandler = {
            self.FAQsquare.hidden = true
            self.creditsSquare.hidden = false
            self.areYouSureSquare.hidden = true
            self.settingsSquare.hidden = true
        }
        tryAgainButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
            self.pauseScreen.hidden = true
            self.gameState = .play
            if self.userLevel == 0 {
                self.gameState = .tutorial
            }
        }
        
        
        if GameManager.sharedInstance.restart == false {
            gameState = .pause
            playButton.selectedHandler = {
                self.pauseFog.hidden = true
                self.playButton.hidden = true
                self.playSquare.hidden = true
                if self.userLevel != 0 {
                    self.gameState = .play
                } else {
                    self.gameState = .tutorial
                }
            }
        }
        
        /*Tutorial*/
        levelSpecifications.append([1, 3, 0])
        /*level 1*/
        levelSpecifications.append([3, 3, 1])
        /*level 2*/
        levelSpecifications.append([5, 3, 1])
        /*level 3*/
        levelSpecifications.append([7, 3, 1])
        /*level 4*/
        levelSpecifications.append([7, 3, 1])
        /*level 5*/
        levelSpecifications.append([7, 3, 2])
        /*level 6*/
        levelSpecifications.append([10, 3, 3])
        /*level 7*/
        levelSpecifications.append([7, 3, 2])
        /*level 8*/
        levelSpecifications.append([10, 3, 1])
        /*level 9*/
        levelSpecifications.append([10, 3, 2])
        /*level 10*/
        levelSpecifications.append([10, 1, 2])
        
        
        coins = GameManager.sharedInstance.money
        levelLabel.text = String(userLevel)
        moneyLabel.text = String(coins)
        progressBar.size.width = 0
        plantsNeeded = levelSpecifications[userLevel][0]
        lives = levelSpecifications[userLevel][1]
        difficulty = levelSpecifications[userLevel][2]
        
        plantsOutOf.text = String(0) + "/" + String(plantsNeeded)
        switch lives {
        case 1:
            life2.hidden = true
            life3.hidden = true
        case 2:
            life3.hidden = true
        case 0:
            life1.hidden = true
            life2.hidden = true
            life3.hidden = true
        default:
            print("")
        }
        
        if difficulty == 1 {
            spawnEvery = 6.0
        } else if difficulty == 2 {
            spawnEvery = 5.0
        } else if difficulty == 3 {
            spawnEvery = 5.0
        } else if difficulty == 0 {
            spawnTimer = 10000000000.0
            spawnEvery = 10000000000.0
        }
        
        if userLevel == 0 {
            levelLabel.hidden = true
            levelUseless.text = "Tutorial"
        } else {
            levelLabel.hidden = false
            levelUseless.text = "Level"
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if gameState == .play || gameState == .tutorial {
            /*update timers*/
            waterTimer += fixedDelta
            seedTimer += fixedDelta
            liftTimer += fixedDelta
            spawnTimer += fixedDelta
            pulseWaterTimer += fixedDelta
            pulseSeedTimer += fixedDelta
            
            /*turn off stage actions*/
            if waterTimer > 1.5 {
                water.removeFromParent()
            }
            if seedTimer > 1 {
                self.seed.removeFromParent()
            }
            
            if spawnTimer > spawnEvery {
                spawnAPlant()
                spawnTimer = 0.0
            }
            
            /*functions called every frame*/
            newMovePlants()
        }
    }
    
    func spawnAPlant() {
        let newPlant = hensAndChicks(texture: SKTexture(imageNamed: "20 hensandchicks"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "20 hensandchicks").size())
            initializePlant(newPlant)
    }
    
    func initializePlant(newPlant: Plant) {
        newPlant.physicsBody = SKPhysicsBody(rectangleOfSize: newPlant.size)
        newPlant.physicsBody?.mass = 10.0
        newPlant.physicsBody?.affectedByGravity = true
        newPlant.physicsBody?.linearDamping = 0.0
        newPlant.physicsBody?.contactTestBitMask = 3
        newPlant.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
        newPlant.position = CGPoint(x: 554, y: 151)
        newPlant.zPosition = 1
        plantsInTheScene.append(newPlant)
        newPlant.physicsBody?.allowsRotation = false
        self.addChild(newPlant)
    }
    func newMovePlants() {
        var i = 0
        for plant in plantsInTheScene {
            if plant.position.x < 356 && plant.currentTexture < 1 {
                dropPlant(plant)
                plantsInTheScene.removeAtIndex(i)
                spawnAPlant()
                seedEmitter.removeAllActions()
                continue
            } else if plant.position.x < 166 && plant.currentTexture < (plant.textures.count - 1) {
                dropPlant(plant)
                plantsInTheScene.removeAtIndex(i)
                spawnAPlant()
                waterEmitter.removeAllActions()
                continue
            } else if plant.position.x < 15 {
                if plant.finished == false {
                    plant.finished = true
                    takePlant(plant)
                }
            } else {
                plant.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
            }
        i += 1
        }
    }
    
    
    func pulse(node: SKSpriteNode) {
        pauseFog.hidden = false
        plantsInTheScene[0].zPosition = 3
        node.zPosition = 3
        let pulse = SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)])
        let pulseForever = SKAction.repeatActionForever(pulse)
        node.runAction(pulseForever)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        let contactA:SKPhysicsBody = contact.bodyA
        let contactB:SKPhysicsBody = contact.bodyB
        
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        
        if (nodeA.name == "seedContact" && nodeB.name != "seed" ||  nodeB.name == "seedContact" && nodeA.name != "seed") &&  pulseSeedTimer > 4 {
            pulseSeedTimer = 0.0
            pulse(seedEmitter)
            
        }
        if (nodeA.name == "waterContact" || nodeB.name == "waterContact") && pulseWaterTimer > 4 {
            pulseWaterTimer = 0.0
            pulse(waterEmitter)
        }

        if nodeA.name == "seed" && nodeB.name != "seedEmitter" {
            nodeA.hidden = true
            plantSeed(nodeB)
        } else if nodeB.name == "seed" && nodeA.name != "seedEmitter" {
            plantSeed(nodeA)
            nodeB.hidden = true
        }
        
        if nodeA.name == "water" {
            
            waterPlant(nodeB)
            
        } else if nodeB.name == "water" {
            
            waterPlant(nodeA)
            
        }
    }
    
    func takePlant(plant: SKSpriteNode) {
        if self.soundOn == 1 {
            self.runAction(SKAction.playSoundFileNamed("complete", waitForCompletion: false))
        }
        plantsCompleted += 1
        let widthToGo = CGFloat((Double(plantsCompleted) * 144.0) / Double(plantsNeeded))
        progressBar.runAction(SKAction.resizeToWidth(widthToGo, duration: 0.5))
        coins += 1
        moneyLabel.runAction(SKAction.sequence([SKAction.scaleTo(1.5, duration: 0.3), SKAction.scaleTo(1, duration: 0.3)]))
        coinsPic.runAction(SKAction.sequence([SKAction.rotateByAngle(-1, duration: 0.2), SKAction.rotateByAngle(1.5, duration: 0.2), SKAction.rotateByAngle(-0.5, duration: 0.2)]))
        GameManager.sharedInstance.money = coins
        plantsOutOf.text = String(plantsCompleted) + "/" + String(plantsNeeded)
        moneyLabel.text = String(coins)
        NSUserDefaults.standardUserDefaults().synchronize()
        GameManager.sharedInstance.saveData()
        plant.physicsBody?.affectedByGravity = false
        let moveOut = SKAction.moveBy(CGVector(dx:50, dy: 0), duration: 0.5)
        let moveIn = SKAction.moveBy(CGVector(dx:-50, dy: 0), duration: 0.8)
        let sequenceHand = SKAction.sequence([moveOut, moveIn])
        let waitPlant = SKAction.waitForDuration(1)
        let plantSequence = SKAction.sequence([waitPlant, moveIn, disappear])
        plant.runAction(plantSequence)
        hand.runAction(sequenceHand, completion: {
            if self.plantsCompleted == self.plantsNeeded {
                self.mixpanel.track("Level Completed", properties: ["Level Number": self.userLevel])
                self.pauseFog.hidden = false
                self.runAction(SKAction.runBlock({
                    self.levelUpNotification.hidden = false
                    self.levelUpNotification.runAction(SKAction.rotateByAngle(6.28, duration: 0.5))
                    self.levelUpNotification.runAction(SKAction.scaleTo(3, duration: 1))
                    let particles = SKEmitterNode(fileNamed: "levelupeffect")!
                    
                    /* Convert node location (currently inside Level 1, to scene space) */
                    particles.position = CGPoint(x: 310, y: 160)
                    
                    /* Restrict total particles to reduce runtime of particle */
                    particles.numParticlesToEmit = 700
                    particles.zPosition = 3
                    /* Add particles to scene */
                    self.addChild(particles)
                    self.runAction(SKAction.waitForDuration(3), completion: {
                        self.userLevel += 1
                        GameManager.sharedInstance.level = self.userLevel
                        self.gameState = .levelUp
                        
                        let skView = self.view as SKView!
                        if self.userLevel != 1 {
                            let scene = levelUp(fileNamed:"levelUp") as levelUp!
                            scene.scaleMode = .AspectFit
                            skView.showsFPS = true
                            skView.showsNodeCount = true
                            skView.presentScene(scene)
                        } else {
                            let scene = GameScene(fileNamed:"GameScene") as GameScene!
                            scene.scaleMode = .AspectFit
                            skView.showsFPS = true
                            skView.showsNodeCount = true
                            skView.presentScene(scene)
                        }
                        
                    })
                }))
            }
        })
    }
    
    func dropPlant(plant: Plant) {
        self.mixpanel.track("Plant dropped", properties: ["Plant position": String(plant.position)])
        pauseFog.hidden = true
        if plant.currentTexture != 0 {
            plant.currentTexture += 1
            if self.soundOn == 1 {
                self.runAction(SKAction.playSoundFileNamed("dry", waitForCompletion: false))
            }
        }
        plant.runAction(SKAction.animateWithTextures([plant.textures[plant.currentTexture]], timePerFrame: 0.5), completion: {
            plant.physicsBody?.collisionBitMask = 0
            let rotate = SKAction.rotateByAngle(0.5, duration: 0.5)
            let fall = SKAction.moveBy(CGVector(dx: -2, dy: -10), duration: 1)
            let fade = SKAction.fadeOutWithDuration(0.3)
            if self.soundOn == 1 {
                let breaksound = SKAction.playSoundFileNamed("correctbreak", waitForCompletion: false)
                let fadeOutSequence = SKAction.sequence([rotate, fall, self.disappear])
                plant.runAction(fadeOutSequence)
                plant.runAction(SKAction.sequence([fade, breaksound]))
            } else {
                let fadeOutSequence = SKAction.sequence([rotate, fall, self.disappear])
                plant.runAction(fadeOutSequence)
                plant.runAction(SKAction.sequence([fade]))
            }
            
        })
        lives -= 1
        switch lives {
        case 1:
            life2.hidden = true
            life3.hidden = true
        case 2:
            life3.hidden = true
        case 0:
            life1.hidden = true
            life2.hidden = true
            life3.hidden = true
            gameState = .gameOver
            pauseFog.hidden = false
            gameOverSquare.hidden = false
            gameOverSquare.runAction(SKAction.sequence([SKAction.moveToX(284.262, duration: 0.3), SKAction.moveBy(CGVector(dx: 0, dy: 10), duration: 0.2), SKAction.moveBy(CGVector(dx: 0, dy: -10), duration: 0.2)]))
            tryAgainButton.hidden = false
            Chartboost.showInterstitial(CBLocationHomeScreen)
            tryAgainButton.runAction(SKAction.sequence([SKAction.moveToX(276.662, duration: 0.3), SKAction.rotateByAngle(-0.3, duration: 0.3), SKAction.rotateByAngle(0.4, duration: 0.2), SKAction.rotateByAngle(-0.1, duration: 0.1)]))
        default:
            print("")
        }
        
    }
    
    func plantSeed (node: SKNode) {
        if self.soundOn == 1 {
            self.runAction(SKAction.playSoundFileNamed("correctcrow", waitForCompletion: false))
        }
        seedEmitter.removeAllActions()
        let plant = node as! Plant
        if plant.hasSeed == true {return}
        plant.plantSeed()
        if userLevel == 1 {
            plant.currentTexture += 3
        } else {
            plant.currentTexture += 1
        }
        //    plant.setScale(1)
        plant.texture = plant.textures[plant.currentTexture]
        plant.size = (plant.texture!.size())
        plant.physicsBody = SKPhysicsBody(rectangleOfSize: (plant.size))
        //    plant.setScale(1.1)
        
    }
    
    func waterPlant (node: SKNode) {
        if self.soundOn == 1 {
            self.runAction(SKAction.playSoundFileNamed("correctcrow", waitForCompletion: false))
        }
        waterEmitter.removeAllActions()
        let plant = node as! Plant
        if plant.wasWatered == true {return}
        plant.wasWatered = true
        plant.water()
        plant.currentTexture = (plant.textures.count - 1)
        //  plant.setScale(1)
        plant.texture = plant.textures[plant.currentTexture]
        plant.size = (plant.texture!.size())
        plant.physicsBody = SKPhysicsBody(rectangleOfSize: (plant.size))
        //   plant.setScale(1.1)
    }

}
