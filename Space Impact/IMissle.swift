//
//  IMissle.swift
//  Space Impact
//
//  Created by Chieh on 3/5/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

protocol IMissle {
    var Missle:SpriteActor{get}
    var Speed:CGFloat { get set}
    var Damage:CGFloat{get set}
    
    func Update()
    func SetActive(_ isActive: Bool)
    func IsCollidedWith(_ actor: SpaceshipActor) -> Bool

}
