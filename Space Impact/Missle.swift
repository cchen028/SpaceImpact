//
//  Missle.swift
//  Space Impact
//
//  Created by Chieh on 3/4/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Missle: MissleActor {
    fileprivate var _misPosition:CGPoint;
    fileprivate let _SPEED:CGFloat = 5;
    fileprivate let _DAMAGE:CGFloat = 1;
    
    var Position:CGPoint{get{return self._missle.position}}
    var IsActive:Bool{get{return self._missle.IsActive}};
    var Sprite:SpriteActor { get{return self._missle}}

    init(missleName:String, position:CGPoint, type:ActorType, speed:CGFloat, damage:CGFloat, xspeed:CGFloat = 0) {
        self._misPosition = position;
        super.init(missleName: missleName, missleType: type,position:position, speed: speed, damage: damage, xspeed: xspeed);
    }
    
    init(missleAtlasName:String, position:CGPoint, type:ActorType, speed:CGFloat, damage:CGFloat, xspeed:CGFloat = 0, timePerFrame: Double = GeneralGameSettings.MyMissle_Frequency)
    {
        self._misPosition = position;
        super.init(missleAtlasName: missleAtlasName, missleType:  type,position:position, speed: speed, damage: damage, xspeed: xspeed,timePerFrame: timePerFrame);
    }
    
    override func Update(){
        super.Update();
    }
    
    override func SetActive(_ isActive: Bool) {
        super.SetActive(isActive);
    }
    
    func SetMissleEndPosition(targetPos: CGPoint){
        self._misEndPosition = targetPos;
    }
}
