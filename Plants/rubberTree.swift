//
//  rubberTree.swift
//  Plants
//
//  Created by Юлия Хазиева on 22.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class rubberTree: Plant {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        kindOfPlant = "Rubber tree"
        textures = [SKTexture(imageNamed: "30 ficus"), SKTexture(imageNamed: "31 ficus"), SKTexture(imageNamed: "31b ficus"),SKTexture(imageNamed: "32 ficus"), SKTexture(imageNamed: "32b ficus"), SKTexture(imageNamed: "33 ficus"), SKTexture(imageNamed: "33b ficus"), SKTexture(imageNamed: "34 ficus"), SKTexture(imageNamed: "34b ficus"), SKTexture(imageNamed: "35 ficus"), SKTexture(imageNamed: "35b ficus"), SKTexture(imageNamed: "36 ficus")]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
}