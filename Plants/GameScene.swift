    //
    //  GameScene.swift
    //  Plants
    //
    //  Created by Юлия Хазиева on 11.07.16.
    //  Copyright (c) 2016 Юлия Хазиева. All rights reserved.

    
    //  todo: stop after level 5
    //  todo: try to break everything
    //  todo: gameover sound
    //  todo: playbuttonsound
    //  todo: levelup sound
    //  todo: proper settings
    
    //  todo: garden
    //  todo: 3 conveyers

    import Mixpanel
    import SpriteKit
    enum GameState {
        case pause, play, tutorial, levelUp, gameOver, garden
    }
    class GameScene: SKScene, SKPhysicsContactDelegate {
        
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
        var lightEmitter: MSButtonNode!
        var light: SKSpriteNode!
        var fertelizeEmitter: MSButtonNode!
        var fertelizer: SKSpriteNode!
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
        var lightContact: SKSpriteNode!
        var waterContact: SKSpriteNode!
        var fertContact: SKSpriteNode!
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
            lightEmitter = childNodeWithName("lightEmitter") as! MSButtonNode
            fertelizeEmitter = childNodeWithName("fertelizeEmitter") as! MSButtonNode
            fertelizer = childNodeWithName("fertelizer") as! SKSpriteNode
            light = childNodeWithName("light") as! SKSpriteNode
            hensAndChicksInstance = childNodeWithName("hensAndChicks") as! hensAndChicks
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
            lightContact = childNodeWithName("lightContact") as! SKSpriteNode
            waterContact = childNodeWithName("waterContact") as! SKSpriteNode
            fertContact = childNodeWithName("fertContact") as! SKSpriteNode
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
            print(soundOn)
            soundOn = GameManager.sharedInstance.soundOn
            print(soundOn)
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
            
            
            fertelizer.removeFromParent()
            water.removeFromParent()
            seed.removeFromParent()
            light.removeFromParent()
            
            
            gameOverSquare.hidden = true
            tryAgainButton.hidden = true
            creditsSquare.hidden = true
            
            if userLevel == 1 || userLevel == 0 {
                waterEmitter.hidden = true
            } else {
                waterEmitter.hidden = false
            }
            
            if userLevel < 4 {
                fertelizeEmitter.hidden = true
            } else {
                fertelizeEmitter.hidden = false
            }
            
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
                    self.seed.position = CGPoint(x: 401, y: 127)
                    self.seed.hidden = false
                    let fall = SKAction.moveBy(CGVector(dx: 0, dy: -100), duration: 1)
                    self.seed.runAction(fall)
                }
            }
            
            waterEmitter.selectedHandler = {
                let particles = SKEmitterNode(fileNamed: "showerEffect")!
                
                /* Convert node location (currently inside Level 1, to scene space) */
                particles.position = CGPoint(x: 226, y: 114)
                
                /* Restrict total particles to reduce runtime of particle */
                particles.numParticlesToEmit = 700
                
                /* Add particles to scene */
                self.addChild(particles)
                if self.waterTimer > 1.5 {
                    if self.soundOn == 1 {
                        self.runAction(SKAction.playSoundFileNamed("water", waitForCompletion: false))
                    }
                    self.waterTimer = 0.0
                   self.addChild(self.water)
               //     self.water.zPosition = 1
                }
            }
            
            fertelizeEmitter.selectedHandler = {
                let particles = SKEmitterNode(fileNamed: "fert effect")!
               
                /* Convert node location (currently inside Level 1, to scene space) */
                particles.position = CGPoint(x: 390, y: 254)
                
                /* Restrict total particles to reduce runtime of particle */
                particles.numParticlesToEmit = 500
                particles.physicsBody?.contactTestBitMask = 0
                /* Add particles to scene */
                self.addChild(particles)

                if self.fertelizerTimer > 1.5 {
                    if self.soundOn == 1 {
                        self.runAction(SKAction.playSoundFileNamed("correctsoil", waitForCompletion: false))
                    }
                    self.fertelizerTimer = 0.0
                    self.addChild(self.fertelizer)
           //         self.fertelizer.zPosition = 1
                }
            }
            
            lightEmitter.selectedHandler = {
                if self.lightTimer > 1.5 {
                    if self.soundOn == 1 {
                        self.runAction(SKAction.playSoundFileNamed("light", waitForCompletion: false))
                    }
                    if self.userLevel == 0 {
                        self.pauseFog.hidden = true
                        self.lightEmitter.zPosition = 1
                    }
                 //   self.light.zPosition = 1
                    self.lightTimer = 0.0
        //            self.light.zPosition = 1
                    self.addChild(self.light)
                }
            }
            
            pauseButton.selectedHandler = {
                if self.liftmoving {
                    let liftCopy = self.childNodeWithName("liftCopy") as! SKSpriteNode
                    if liftCopy.position.y < 149 {
                    liftCopy.removeAllActions()
                    if self.gameState != .pause {
                        self.pauseScreen.runAction(SKAction.moveBy(CGVector(dx: -90, dy: 0), duration: 0.5))
                        self.gameState = .pause
                        for plant in self.plantsInTheScene {
                            plant.physicsBody?.pinned = true
                        }
                        self.pauseFog.hidden = false
                    }
                }

            } else {
                    if self.gameState != .pause {
                        self.pauseScreen.runAction(SKAction.moveBy(CGVector(dx: -90, dy: 0), duration: 0.5))
                        self.gameState = .pause
                        for plant in self.plantsInTheScene {
                            plant.physicsBody?.pinned = true
                        }
                        self.pauseFog.hidden = false
                    }
                }
            }
            
            resumeButton.selectedHandler = {
                
                self.liftAfterPause()
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
                print(self.userLevel)
                print(self.gameState)
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
                lightTimer += fixedDelta
                fertelizerTimer += fixedDelta
                seedTimer += fixedDelta
                liftTimer += fixedDelta
                spawnTimer += fixedDelta
                pulseWaterTimer += fixedDelta
                pulseLightTimer += fixedDelta
                pulseFertilizerTimer += fixedDelta
                pulseSeedTimer += fixedDelta
                
                /*turn off stage actions*/
                if waterTimer > 1.5 {
                    water.removeFromParent()
                }
                if fertelizerTimer > 1.5 {
                    fertelizer.removeFromParent()
                }
                if lightTimer > 1.5 {
                    light.removeFromParent()
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
            if difficulty == 3 {
                var randomSpawn = (Double)(arc4random_uniform((UInt32)(3))) + 4.0
                spawnEvery = randomSpawn
               
            }
            let randomNumber = (Int)(arc4random_uniform((UInt32)(unlockedPlants.count)))
            switch unlockedPlants[randomNumber] {
            case let plant as hensAndChicks:
                let newPlant = hensAndChicks(texture: SKTexture(imageNamed: "20 hensandchicks"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "20 hensandchicks").size())
                initializePlant(newPlant)
            case let plant as cereusPeruvianus:
                let newPlant = cereusPeruvianus(texture: SKTexture(imageNamed: "60 cereus"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "60 cereus").size())
                initializePlant(newPlant)
            case let plant as aloe:
                let newPlant = aloe(texture: SKTexture(imageNamed: "10 aloe"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "10 aloe").size())
                initializePlant(newPlant)
            case let plant as jadePlant:
                let newPlant = jadePlant(texture: SKTexture(imageNamed: "40 money tree"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "40 money tree").size())
                initializePlant(newPlant)
            case let plant as englishIvy:
                let newPlant = englishIvy(texture: SKTexture(imageNamed: "50 ivy"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "50 ivy").size())
                initializePlant(newPlant)
            case let plant as rubberTree:
                let newPlant = rubberTree(texture: SKTexture(imageNamed: "30 ficus"), color: UIColor.clearColor(), size: SKTexture(imageNamed: "30 ficus").size())
                initializePlant(newPlant)
            default:
                break
            }
        }
        func initializePlant(newPlant: Plant) {
            newPlant.physicsBody = SKPhysicsBody(rectangleOfSize: newPlant.size)
            newPlant.physicsBody?.mass = 10.0
            newPlant.physicsBody?.affectedByGravity = true
            newPlant.physicsBody?.linearDamping = 0.0
            newPlant.physicsBody?.contactTestBitMask = 3
            newPlant.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
            newPlant.position = CGPoint(x: 530, y: 40)
            newPlant.zPosition = 1
            plantsInTheScene.append(newPlant)
            newPlant.physicsBody?.allowsRotation = false
          //  newPlant.setScale(1.1)
            self.addChild(newPlant)
        }
        func newMovePlants() {

            if gameState == .tutorial {
                var i = 0
                for plant in plantsInTheScene {
                    if plant.position.x < 340 && plant.currentTexture < 1 {
                        dropPlant(plant)
                        plantsInTheScene.removeAtIndex(i)
                        spawnAPlant()
                        seedEmitter.removeAllActions()
                        continue
                    } else if plant.position.y < 65 {
                       
                        if plant.position.x > 55 {
                            plant.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                        }  else if plant.position.x < 58 {
                            if plant.isOnLift == false {
                                plant.isOnLift = true
                                self.liftPlant()
                            }
                        }
                        if plant.hasSeed == false  {
                            plant.zPosition = 3
                            seedEmitter.zPosition = 3
                            seed.zPosition = 3
                        }
                    } else if plant.position.y > 165 {
                        if plant.position.x > 245 && plant.currentTexture < 5 {
                            
                            dropPlant(plant)
                            plantsInTheScene.removeAtIndex(i)
                            lightEmitter.removeAllActions()
                            spawnAPlant()
                            continue
                        }  else if plant.position.x < 532 {
                            plant.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
                        }  else if plant.position.x >= 532 {
                            if plant.finished == false {
                                plant.finished = true
                                takePlant(plant)
                            }
                        }
                        if plant.wasShinedAt == false {
                            plant.zPosition = 3
                            lightEmitter.zPosition = 3
                        }
                    }
                    i += 1
                }
            } else {
                var i = 0
                for plant in plantsInTheScene {
                  
                    if plant.position.y < 65 {
                        if plant.position.x < 340 && plant.currentTexture < 1 {
                            seedEmitter.removeAllActions()
                            dropPlant(plant)
                            plantsInTheScene.removeAtIndex(i)
                            continue
                        } else if plant.position.x < 160 && plant.currentTexture < 3 {
                            waterEmitter.removeAllActions()
                            print(gameState)
                            dropPlant(plant)
                            plantsInTheScene.removeAtIndex(i)
                            continue
                        } else if plant.position.x > 55 {
                            plant.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                        } else if plant.position.x < 58 {
                            if plant.isOnLift == false {
                                plant.isOnLift = true
                                self.liftPlant()
                            }
                        }
                    } else if plant.position.y > 165 {
                        if plant.position.x > 245 && plant.currentTexture < 5 {
                            lightEmitter.removeAllActions()
                            dropPlant(plant)
                            plantsInTheScene.removeAtIndex(i)
                        } else if plant.position.x > 440 && plant.currentTexture < 11 {
                            fertelizeEmitter.removeAllActions()
                            dropPlant(plant)
                            plantsInTheScene.removeAtIndex(i)
                            continue
                        } else if plant.position.x < 532 {
                            plant.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
                        } else {
                            if plant.finished == false {
                                plant.finished = true
                                takePlant(plant)
                            }
                        }
                    }
                    i += 1
                }
            }
        }
        
        
        func pulse(node: SKSpriteNode) {
            if userLevel == 0 {
                pauseFog.hidden = false
                plantsInTheScene[0].zPosition = 3
                node.zPosition = 3
            }
            let pulse = SKAction.sequence([SKAction.scaleTo(0.8, duration: 0.5), SKAction.scaleTo(1, duration: 0.5)])
            let pulseForever = SKAction.repeatActionForever(pulse)
            node.runAction(pulseForever)

        }
        
        func liftPlant() {
            liftTimer = 0.0
            let liftUp = SKAction.moveBy(CGVector(dx: 0, dy: 125), duration: 1.5)
            let wait = SKAction.waitForDuration(1)
            let copySequence = SKAction.sequence([liftUp, wait, disappear])
            let liftCopy = lift.copy() as! SKSpriteNode
            liftCopy.name = "liftCopy"
            liftCopy.physicsBody?.collisionBitMask = 2
            liftCopy.physicsBody?.categoryBitMask = 2
            lift.removeFromParent()
            self.addChild(liftCopy)
            liftmoving = true
            liftCopy.runAction(copySequence, completion: {
                self.liftmoving = false
                self.addChild(self.lift)
            })
        }
        
        func liftAfterPause() {
           
            if liftmoving {
                let liftCopy = self.childNodeWithName("liftCopy") as! SKSpriteNode
                print(liftCopy.position.y)
                liftCopy.physicsBody?.pinned = false
                let dy = 150 - liftCopy.position.y
                let duration = 1.5 / 125 * dy
                let liftUp = SKAction.moveBy(CGVector(dx: 0, dy: dy), duration: Double(duration))
                let wait = SKAction.waitForDuration(0.7)
                let copySequence = SKAction.sequence([liftUp, wait, disappear])
                liftCopy.runAction(copySequence, completion: {
                    self.addChild(self.lift)
                    self.liftmoving = false
                })
            }
        }
        
        func didBeginContact(contact: SKPhysicsContact) {
            
            let contactA:SKPhysicsBody = contact.bodyA
            let contactB:SKPhysicsBody = contact.bodyB
            
            let nodeA = contactA.node!
            let nodeB = contactB.node!
            

            if (nodeA.name == "seedContact" && nodeB.name != "seed" ||  nodeB.name == "seedContact" && nodeA.name != "seed") &&  pulseSeedTimer > 4 {
                    pulseSeedTimer = 0.0
                    pulse(seedEmitter)
                print(String(nodeA) + " " + String(nodeB))
            }
            if (nodeA.name == "waterContact" || nodeB.name == "waterContact") && pulseWaterTimer > 4 {
                print(String(nodeA) + " " + String(nodeB))
                    pulseWaterTimer = 0.0
                if userLevel > 1 {
                    pulse(waterEmitter)
                }
            } else if (nodeA.name == "lightContact" || nodeB.name == "lightContact") && pulseLightTimer > 4{
                pulseLightTimer = 0.0
                pulse(lightEmitter)
                print(String(nodeA) + " " + String(nodeB))
            } else if (nodeA.name == "fertContact" || nodeB.name == "fertContact") && pulseFertilizerTimer > 4 {
                pulseFertilizerTimer = 0.0
                if userLevel > 3 {
                pulse(fertelizeEmitter)
                print(String(nodeA) + " " + String(nodeB))
                }
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
            
            if nodeA.name == "light" {
                
                    shineLightAt(nodeB)
               
            } else if nodeB.name == "light" {
                
                    shineLightAt(nodeA)
              
            }
            
            if nodeA.name == "fertelizer"{
               
                    fertelize(nodeB)
                
            } else if nodeB.name == "fertelizer" {
                
                    fertelize(nodeA)
                
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
            let moveOut = SKAction.moveBy(CGVector(dx:-50, dy: 0), duration: 0.5)
            let moveIn = SKAction.moveBy(CGVector(dx:50, dy: 0), duration: 0.8)
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
            plant.currentTexture += 2
          //  plant.setScale(1)
            plant.texture = plant.textures[plant.currentTexture]
            plant.size = (plant.texture!.size())
            plant.physicsBody = SKPhysicsBody(rectangleOfSize: (plant.size))
         //   plant.setScale(1.1)
        }
        
        func shineLightAt (node: SKNode) {
            if self.soundOn == 1 {
                self.runAction(SKAction.playSoundFileNamed("correctcrow", waitForCompletion: false))
            }
            lightEmitter.removeAllActions()
            let plant = node as! Plant
            if plant.wasShinedAt == true {return}
            plant.shineAt()
            plant.currentTexture += 2
            if userLevel < 4 {
                plant.currentTexture = (plant.textures.count - 1)
            }
       //     plant.setScale(1)
            plant.texture = plant.textures[plant.currentTexture]
            plant.size = (plant.texture!.size())
            plant.physicsBody = SKPhysicsBody(rectangleOfSize: (plant.size))
       //     plant.setScale(1.1)
        }
        
        func fertelize (node: SKNode) {
            if self.soundOn == 1 {
                self.runAction(SKAction.playSoundFileNamed("correctcrow", waitForCompletion: false))
            }
            fertelizeEmitter.removeAllActions()

            let plant = node as! Plant
            if plant.hasFertelizer == true {return}
            plant.fertelize()
            plant.currentTexture = plant.textures.count - 1
        //    plant.setScale(1)
            plant.texture = plant.textures[plant.currentTexture]
            plant.size = (plant.texture!.size())
            plant.physicsBody = SKPhysicsBody(rectangleOfSize: (plant.size))
         //   plant.setScale(1.1)
        }
    }
