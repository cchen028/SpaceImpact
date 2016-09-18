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
    var _isActive:Bool;
    var _missle:SpriteActor;
    
    fileprivate var _speed:CGFloat;
    fileprivate var _damage:CGFloat;
    fileprivate var _gameScene:GameScene;
    
    var Missle:SpriteActor{get{return self._missle}};
    var Speed:CGFloat { get{return self._speed} set(val){self._speed = val}}
    var Damage:CGFloat{get{return self._damage} set(val){self._damage = val}}
    
    init(gs:GameScene, missleType: ActorType,position:CGPoint, speed:CGFloat,damage:CGFloat) {
        
        self._gameScene = gs;
        self._speed = speed;
        self._damage = damage;
        self._isActive = false;
        self._missle = SpriteActor(gs:gs, imageName: GeneralGameSettings.MyMissle_Name, position: position, scale: 1, opacity: 1, type: missleType);
        self._missle.name = missleType.rawValue;
    }
    
    func Update(){

    }
        
   
    
    func Active(){
      //  GameScene.gameScene.childNode(withName: NodeType.GameScreen.rawValue)?.addChild(self._missle);
        self._gameScene.childNode(withName: NodeType.GameScreen.rawValue)?.addChild(self._missle);
    }
    
    func InActive() {
        self.Missle.removeFromParent();
    }
    
    func IsCollideWithSelf(_ actor: SpriteActor) -> Bool{
        return self.Missle.frame.intersects(actor.frame);
    }
}


enum MissleType: Int{
    case missleDefault = 1, enemyMissle
}
