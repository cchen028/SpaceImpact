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
    fileprivate let _SPEED:CGFloat = 5;
    fileprivate let _DAMAGE:CGFloat = 1;
    
    
    var Position:CGPoint{get{return self.Missle.position}}
    var IsActive:Bool{get{return _isActive}};
    var Sprite:SpriteActor { get{return self.Missle}}
    
    init(position:CGPoint, type:ActorType) {
        self._misPosition = position;
        super.init(missleType: type,position:position, speed: self._SPEED, damage: self._DAMAGE);
    }
    
    override func Update(){
        if(self._isActive)
        {
            self._missle.position.y += self._SPEED;
        }
        
        
        if self._missle.position.y > CGFloat(GeneralGameSettings.SCREEN_HEIGHT)
        {
            self._missle.SetActive(false);
        }
    }
    
    func SetActive(_ isActive: Bool) {
        if(self.IsActive != isActive){
            UpdateStatus(isActive);
        }
        
        self._isActive = isActive;
    }
    
    override func UpdateStatus(_ isActive: Bool){
        super.UpdateStatus(isActive);
    }
    
    func Explode() {
        
    }
}
