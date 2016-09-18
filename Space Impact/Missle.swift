//
//  Missle.swift
//  Space Impact
//
//  Created by Chieh on 3/4/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Missle: MissleActor, IActor {
    fileprivate var _misPosition:CGPoint;
    fileprivate var _gameScene:GameScene?;
    fileprivate let _SPEED:CGFloat = 5;
    fileprivate let _DAMAGE:CGFloat = 1;
    
    
    var Position:CGPoint{get{return self.Missle.position}}
    var IsActive:Bool{get{return _isActive}};
    var Sprite:SpriteActor { get{return self.Missle}}
    
    init(gs:GameScene, position:CGPoint, type:ActorType) {
        self._gameScene = gs;
        self._misPosition = position;
        super.init(gs:gs, missleType: type,position:position, speed: self._SPEED, damage: self._DAMAGE);
    }
    
    override func Update(){
        if(self._isActive)
        {
            self._missle.position.y += self._SPEED;
        }
    }
    
    func SetActive(_ isActive: Bool) {
        if(self._isActive == isActive)
        {
            return;
        }
        else{
            self._isActive = isActive;
        }
        
        if(isActive){
            Active();
        }
        else
        {
            InActive();
        }
    }
    
    func Explode() {
        
    }
    
    override func Active() {
        super.Active();
    }
    
    override func InActive() {
        super.InActive();
    }
}
