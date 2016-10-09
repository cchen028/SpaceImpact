//
//  MissleActor.swift
//  Space Impact
//
//  Created by Chieh on 3/5/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class MissleActor: IMissle {
    var _missle:SpriteActor;
    
    fileprivate var _speed:CGFloat;
    fileprivate var _damage:CGFloat;
    
    var Missle:SpriteActor{get{return self._missle}};
    var Speed:CGFloat { get{return self._speed} set(val){self._speed = val}}
    var Damage:CGFloat{get{return self._damage} set(val){self._damage = val}}
    
    init(missleType: ActorType,position:CGPoint, speed:CGFloat,damage:CGFloat) {
        self._speed = speed;
        self._damage = damage;
        self._missle = SpriteActor(imageName: GeneralGameSettings.MyMissle_Name, position: position, scale: 1, opacity: 1, type: missleType);
        self._missle.name = missleType.rawValue;
    }
    
    func Update(){
        if(self._missle.IsActive)
        {
            self._missle.position.y += self._speed;
        }
        
        
        if self._missle.position.y > CGFloat(GeneralGameSettings.SCREEN_HEIGHT)
        {
            self._missle.SetActive(false);
        }
    }
    
    func SetActive(_ isActive: Bool) {
        self._missle.SetActive(isActive);
    }
    
    func IsCollidedWith(_ actor: SpriteActor) -> Bool{
        return actor.IsActive && self._missle.frame.intersects(actor.frame);
    }
}


enum MissleType: Int{
    case missleDefault = 1, enemyMissle
}
