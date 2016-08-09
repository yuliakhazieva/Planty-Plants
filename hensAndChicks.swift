//
//  hensAndChicks.swift
//  Plants
//
//  Created by Юлия Хазиева on 12.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class hensAndChicks: Plant {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        kindOfPlant = "Hens and Chicks"
        textures = [SKTexture(imageNamed: "20 hensandchicks"), SKTexture(imageNamed: "21 hensandchicks"), SKTexture(imageNamed: "21b hensandchicks"), SKTexture(imageNamed: "22 hensandchicks"), SKTexture(imageNamed: "22b hensandchicks"), SKTexture(imageNamed: "23 hensandchicks"), SKTexture(imageNamed: "23b hensandchicks"), SKTexture(imageNamed: "24 hensandchicks"), SKTexture(imageNamed: "24b hensandchicks"), SKTexture(imageNamed: "25 hensandchicks"), SKTexture(imageNamed: "25b hensandchicks"), SKTexture(imageNamed: "26 hensandchicks-1")]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    

}
