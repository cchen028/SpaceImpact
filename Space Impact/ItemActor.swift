//
//  ItemActor.swift
//  Space Impact
//
//  Created by Chieh on 10/22/16.
//  Copyright © 2016 Jay. All rights reserved.
//

//
//  MissleActor.swift
//  Space Impact
//
//  Created by Chieh on 3/5/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class ItemActor {
    var _item:SpriteActor;
    var _item_explosion:SpriteActor;
    
    fileprivate var _speed:CGFloat;
    //fileprivate var _damage:CGFloat;
    fileprivate var _initialPosition: CGPoint;
    // fileprivate var _missleType: MissleType;
    fileprivate var _point:Int;

    
    var Item:SpriteActor{get{return self._item}}
    var ItemExplosion:SpriteActor{get{return self._item_explosion}}
    var Speed:CGFloat { get{return self._speed} set(val){self._speed = val}}
    //var Damage:CGFloat{get{return self._damage} set(val){self._damage = val}}
    var InitialPosition: CGPoint{get{return self._initialPosition} set(val){self._initialPosition = val}}
    var Point:Int {get{return self._point}}

    
    
    init(itemName:String,exposionName:String, itemType: ActorType,position:CGPoint, speed:CGFloat, point:Int = 1000) {
        self._speed = speed;
        self._point = point;
      //  self._damage = damage;
        self._initialPosition = position;
        self._item = SpriteActor(imageName: itemName, position: position, scale: 1, opacity: 1, type: itemType);
        self._item_explosion = SpriteActor(atlasName: exposionName, position: position, scale: 1, opacity: 0, type: ActorType.Explosion, repeatCount: 1, startAnimating: false);
       // self._item = SpriteActor(atlasName: itemName, position: position, scale: 1, opacity: 1, type: itemType, repeatCount: -1, startAnimating: true)
        self._item.name = itemType.rawValue;
        self._item.zPosition = 3;
    }
    
    init(atlasItemName:String,exposionName:String, itemType: ActorType, position:CGPoint, speed:CGFloat, point:Int = 1000){
        self._speed = speed;
        self._point = point;
        //  self._damage = damage;
        self._initialPosition = position;
        //self._item = SpriteActor(imageName: itemName, position: position, scale: 1, opacity: 1, type: itemType);
        self._item = SpriteActor(atlasName: atlasItemName, position: position, scale: 1, opacity: 1, type: itemType, repeatCount: -1, startAnimating: true)
        self._item_explosion = SpriteActor(atlasName: exposionName, position: position, scale: 1, opacity: 0, type: ActorType.Explosion, repeatCount: 1, startAnimating: false);
        self._item.name = itemType.rawValue;
        self._item.zPosition = 3;
    }
    
    func Explode(){
        self._item.SetActive(false);
        
        self._item_explosion.alpha = 1;
        //self._missleTimer.ToggleMissleTimer(isOn: false, targetSpaceship: self, missleFz: 0);
        self._item_explosion.RunAnimation(animationComplete: {
            self._item_explosion.removeAllActions();
        });
    }

    
    func Update(){
        
        self._item_explosion.SyncPositionWith(actor: self._item);
        
            if(self._item.IsActive)
            {
                self._item.position.y -= self._speed;
            }
            
            if self._item.position.y < 0
            {
                self._item.SetActive(false);
            }
    
        
    }
    
    func SetActive(_ isActive: Bool) {
        self._item.SetActive(isActive);
        self._item_explosion.SetActive(isActive);
    }
    
//    func IsCollidedWith(_ actor: SpaceshipActor) -> Bool{
//        return self._item.IsActive && actor.Spaceship.IsActive && self._item.frame.intersects(actor.Spaceship.frame);
//    }
}
