//
//  aloe.swift
//  Plants
//
//  Created by Юлия Хазиева on 22.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class aloe: Plant {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        kindOfPlant = "Aloe"
        textures = [SKTexture(imageNamed: "10 aloe"), SKTexture(imageNamed: "11 aloe"), SKTexture(imageNamed: "11b aloe"), SKTexture(imageNamed: "12 aloe"), SKTexture(imageNamed: "12b aloe"), SKTexture(imageNamed: "13 aloe"), SKTexture(imageNamed: "13b aloe"), SKTexture(imageNamed: "14 aloe"), SKTexture(imageNamed: "14b aloe"), SKTexture(imageNamed: "15 aloe"), SKTexture(imageNamed: "15b aloe"), SKTexture(imageNamed: "16 aloe")]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
}