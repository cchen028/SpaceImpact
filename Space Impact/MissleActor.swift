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
    fileprivate var _initialPosition: CGPoint;
    
    internal var _misEndPosition:CGPoint;
    
    var MissleEndPosition:CGPoint{ get{return self._misEndPosition} set(val){self._misEndPosition = val}}
    var Missle:SpriteActor{get{return self._missle}}
    var Speed:CGFloat { get{return self._speed} set(val){self._speed = val}}
    var Damage:CGFloat{get{return self._damage} set(val){self._damage = val}}
    var InitialPosition: CGPoint{get{return self._initialPosition} set(val){self._initialPosition = val}}

    
    init(missleName:String, missleType: ActorType,position:CGPoint, speed:CGFloat,damage:CGFloat) {
        self._speed = speed;
        self._damage = damage;
        self._misEndPosition = CGPoint(x:0, y:0);
        self._initialPosition = position;
        self._missle = SpriteActor(imageName: missleName, position: position, scale: 1, opacity: 1, type: missleType);
        self._missle.name = missleType.rawValue;
        self._missle.zPosition = 3;
    }
    
    init(missleAtlasName:String, missleType: ActorType,position:CGPoint, speed:CGFloat,damage:CGFloat){
        self._speed = speed;
        self._damage = damage;
        self._misEndPosition = CGPoint(x:0, y:0);
        self._initialPosition = position;
        self._missle = SpriteActor(atlasName:missleAtlasName, position: position, scale: 1, opacity: 1, type:missleType);
        self._missle.name = missleType.rawValue;
        self._missle.zPosition = 3;
    }
    
    func Update(){
        switch self.Missle.Type {
        case .MyMissle:
            if(self._missle.IsActive)
            {
                self._missle.position.y += self._speed;
            }
            
            if self._missle.position.y > CGFloat(GeneralGameSettings.SCREEN_HEIGHT)
            {
                self._missle.SetActive(false);
            }
            break;
        case  .EnemyMissle:
            if(self._missle.IsActive)
            {
                self._missle.position.y -= self._speed;
            }
            
            if self._missle.position.y < 0
            {
                self._missle.SetActive(false);
            }
            break;
        case .BlueBossMissle:
            if(self._missle.IsActive)
            {
                self._missle.position.y -= self._speed;
            }
            
            if(self._missle.position.x > self._misEndPosition.x){
                self._missle.position.x -= 2;
            }
            else if(self._missle.position.x < self._misEndPosition.x){
                self._missle.position.x += 2;
            }
            
            if self._missle.position.y < 0
            {
                self._missle.SetActive(false);
            }
            
            break;
        default :
            break;
        }
        
    }
    
    func SetActive(_ isActive: Bool) {
        self._missle.SetActive(isActive);
        if(isActive){
            self._missle.RunAnimation(animationComplete: {});
        }
    }
    
    func IsCollidedWith(_ actor: SpaceshipActor) -> Bool{
        return self._missle.IsActive && actor.Spaceship.IsActive && self._missle.frame.intersects(actor.Spaceship.frame);
    }
}


enum MissleType: Int{
    case missleDefault = 1, enemyMissle = 2
}
