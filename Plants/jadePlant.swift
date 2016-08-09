//
//  jadePlant.swift
//  Plants
//
//  Created by Юлия Хазиева on 22.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class jadePlant: Plant {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        kindOfPlant = "Jade plant"
        textures = [SKTexture(imageNamed: "40 money tree"), SKTexture(imageNamed: "41 money tree"), SKTexture(imageNamed: "41b money tree"), SKTexture(imageNamed: "42 money tree"), SKTexture(imageNamed: "42b money tree"),SKTexture(imageNamed: "43 money tree"), SKTexture(imageNamed: "43b money tree"),SKTexture(imageNamed: "44 money tree"), SKTexture(imageNamed: "44b money tree"),SKTexture(imageNamed: "45 money tree"), SKTexture(imageNamed: "45b money tree"),SKTexture(imageNamed: "46 money tree")]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
}