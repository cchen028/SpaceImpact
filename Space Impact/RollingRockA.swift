//
//  RollingRockA.swift
//  Space Impact
//
//  Created by Chieh on 3/6/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class RollingRockA: SpaceshipActor{
    
    fileprivate var _initialPosition:CGPoint;
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    init(position:CGPoint)
    {
        self._initialPosition = position;

        super.init(imageName: GeneralGameSettings.ROLLINGROCKA_NAME, explosionName: GeneralGameSettings.ROLLINGROCKA_EXPLOSION, health: GeneralGameSettings.ROLLINGROCKA_HEALTH, speed: GeneralGameSettings.ROLLINGROCKA_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship,  point: GeneralGameSettings.ROLLINGROCKA_POINT, isSpaceShipAnimation: true);
        
    }
    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self.Spaceship.position.y -= self.Speed;
        }
    }
    
}
