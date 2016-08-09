//
//  Plant.swift
//  Plants
//
//  Created by Юлия Хазиева on 12.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class Plant: SKSpriteNode {
    
    var kindOfPlant = ""
    var hasSeed = false
    var wasWatered = false
    var wasShinedAt = false
    var hasFertelizer = false
    var unlocked = false
    var needsWater = true
    var needsLight = true
    var currentTexture = 0
    var isOnLift = false
    var finished = false
    var fixTexture = false
    var textures: [SKTexture] = []
    var gardenPosition = CGPoint(x: 0, y: 0)
        override init (texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func unlock() {
        unlocked = true
    }
    func plantSeed() {
        self.hasSeed = true
    }
    func water() {
        self.wasWatered = true
    }
    func fertelize() {
        self.hasFertelizer = true
    }
    func shineAt() {
        self.wasShinedAt = true
    }
    
}