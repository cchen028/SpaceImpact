//
//  ISpaceship.swift
//  Space Impact
//
//  Created by Chieh on 2/19/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

protocol ISpaceship {
    
    var Health:Int{get set};
    var Speed:CGFloat{get set};
    var Damage:Int{get set};
    var Position:CGPoint{get set};
    var IsActive:Bool{get}
    var Spaceship:SpriteActor{get};
    var Explosion:SpriteActor{get};
    var Missles:[Missle]{get};
    var `Type`:ActorType{get};
    var Point:Int {get};
    
    
    
    func SetActive(_ isActive:Bool);
    func Update();
    func AddMissle();
    func StopMissle();
    func IsCollidedWith(_ actor: SpaceshipActor) -> Bool;
}


