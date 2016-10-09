//
//  IActor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

protocol IActor {
    var Position:CGPoint{get}
    var IsActive:Bool{get}
    var Sprite:SpriteActor{get};
    
    func Update();
    func SetActive(_ isActive:Bool);
}
