//
//  MissleActor.swift
//  Space Impact
//
//  Created by Chieh on 3/5/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class MissleActor: SpriteActor, IMissle {
    private var _speed:CGFloat;
    private var _damage:CGFloat;
    private var _type:MissleType;
    
    var Speed:CGFloat { get{return self._speed} set(val){self._speed = val}}
    var Damage:CGFloat{get{return self._damage} set(val){self._damage = val}}
    var Type:MissleType{get{return self._type} set(val){self._type = val}}
    
    init(missleType: MissleType,position:CGPoint, speed:CGFloat,damage:CGFloat) {
        
        self._type = missleType;
        self._speed = speed;
        self._damage = damage;
        
        switch missleType{
        case MissleType.MissleDefault:
            super.init(imageName: "missle",position:position, scale: 1, opacity: 1);
        default:
            super.init(imageName: "error",position: position, scale: 1, opacity: 1);
            
        }
    }
    
    public func Update(){

    }
}


enum MissleType: Int{
    case MissleDefault = 1, EnemyMissle
}
