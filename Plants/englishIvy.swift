//
//  englishIvy.swift
//  Plants
//
//  Created by Юлия Хазиева on 22.07.16.
//  Copyright © 2016 Юлия Хазиева. All rights reserved.
//

import Foundation
import SpriteKit
class englishIvy: Plant {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        kindOfPlant = "English Ivy"
        textures = [SKTexture(imageNamed: "50 ivy"), SKTexture(imageNamed: "51 ivy"), SKTexture(imageNamed: "51b ivy"), SKTexture(imageNamed: "52 ivy"), SKTexture(imageNamed: "52b ivy"), SKTexture(imageNamed: "53 ivy"), SKTexture(imageNamed: "53b ivy"), SKTexture(imageNamed: "54 ivy"), SKTexture(imageNamed: "54b ivy"), SKTexture(imageNamed: "55 ivy"), SKTexture(imageNamed: "55b ivy"), SKTexture(imageNamed: "56 ivy")]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
}