//
//  GameManager.swift
//  Plants
//
//  Created by Юлия Хазиева on 19.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class GameManager {
    static let sharedInstance = GameManager()
    var soundOn: Int = NSUserDefaults.standardUserDefaults().integerForKey("soundOn") ?? 1 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(soundOn, forKey: "soundOn")
        }
    }
    
    var level: Int = NSUserDefaults.standardUserDefaults().integerForKey("level") ?? 0 {
        willSet {
            print("willset ns to \(NSUserDefaults.standardUserDefaults().integerForKey("level"))")
            print("willset level to \(level)")
        }
        didSet {
            print("didset ns to \(NSUserDefaults.standardUserDefaults().integerForKey("level"))")
            print("didset level to \(level)")
            NSUserDefaults.standardUserDefaults().setInteger(level, forKey:"level")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    var money: Int = NSUserDefaults.standardUserDefaults().integerForKey("money") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(money, forKey:"money")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
   var bufferArray = NSUserDefaults.standardUserDefaults().arrayForKey("bufferArray") ?? [true, false, false, false, false, false] {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(bufferArray, forKey:"bufferArray")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    var dictionary:[Plant: Int] = [:]
    var restart = false
    var aloeInstance  = aloe()
    var englishIvyInstance = englishIvy()
    var jadePlantInstance = jadePlant()
    var rubberTreeInstance = rubberTree()
    var cereusPeruvianusInstance = cereusPeruvianus()
    var hensAndChicksInstance = hensAndChicks()
    
    var lockedPlants: [Plant] = []
    var unlockedPlants: [Plant] = []

    init () {
        dictionary = [hensAndChicksInstance: 0, aloeInstance: 1, englishIvyInstance: 2, jadePlantInstance: 3, rubberTreeInstance: 4, cereusPeruvianusInstance: 5]
        if NSUserDefaults.standardUserDefaults().integerForKey("level") == 0 {
            level = 0
            soundOn = 1
        }
        var i = 0
        for flag in bufferArray! {
            if flag as! Bool == true {
                for key in dictionary.keys {
                    if dictionary[key] == i {
                        unlockedPlants.append(key)
                    }
                }
            } else {
                for key in dictionary.keys {
                    if dictionary[key] == i {
                        lockedPlants.append(key)
                    }
                }
            }
            i += 1
        }
    }
    
    func saveData() {
        for plant in unlockedPlants {
            bufferArray![dictionary[plant]!] = true
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        print(bufferArray)
    }
}