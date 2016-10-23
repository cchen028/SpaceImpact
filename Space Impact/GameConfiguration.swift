//
//  GameConfiguration.swift
//  Space Impact
//
//  Created by Chieh on 10/22/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
import SpriteKit

class GameConfiguration: NSObject {
    
    static let instance = GameConfiguration();
    
    fileprivate var _movementType:Control;
    
    var MoveMentType:Control{get{return self._movementType} set(val){self._movementType = val}};

    
    private override init(){
        self._movementType = .FreeDrag;
    }
    

}

enum Control{
    case FreeDrag, Classic
}
