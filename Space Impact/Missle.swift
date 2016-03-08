//
//  Missle.swift
//  Space Impact
//
//  Created by Chieh on 3/4/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class Missle: MissleActor {
    private var _misPosition:CGPoint;
    private var _gameScene:GameScene?;
    private let _SPEED:CGFloat = 5;
    private let _DAMAGE:CGFloat = 1;
    
    init(gs:GameScene, position:CGPoint) {
        self._gameScene = gs;
        self._misPosition = position;
        super.init(missleType: MissleType.MissleDefault,position:position, speed: self._SPEED, damage: self._DAMAGE);
        
        gs.addActor(self);
    }
    
    override func Update(){
        self.Sprite.position.y += self._SPEED;
        
    }
}
