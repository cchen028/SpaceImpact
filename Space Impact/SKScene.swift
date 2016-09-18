//
//  SKScene.swift
//  Space Impact
//
//  Created by Chieh on 3/13/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

extension SKScene{
    func addSpriteActor(_ object: SpriteActor){
        self.addChild(object);
    }
    
    func childNodeWithNodeType(_ nodeType:NodeType)->SKNode?{
        return self.childNode(withName: nodeType.rawValue);
    }
}
