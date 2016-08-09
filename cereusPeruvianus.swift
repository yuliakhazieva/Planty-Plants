//
//  cereusPeruvianus.swift
//  Plants
//
//  Created by Юлия Хазиева on 12.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class cereusPeruvianus: Plant {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        kindOfPlant = "Cereus Peruvianus"
        textures = [SKTexture(imageNamed: "60 cereus"), SKTexture(imageNamed: "61 cereus"), SKTexture(imageNamed: "61b cereus"), SKTexture(imageNamed: "62 cereus"), SKTexture(imageNamed: "62b cereus"), SKTexture(imageNamed: "63 cereus"), SKTexture(imageNamed: "63b cereus"), SKTexture(imageNamed: "64 cereus"), SKTexture(imageNamed: "64b cereus"), SKTexture(imageNamed: "65 cereus"), SKTexture(imageNamed: "65b cereus"), SKTexture(imageNamed: "66 cereus")]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
}