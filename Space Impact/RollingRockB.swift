//
//  RollingRockB.swift
//  Space Impact
//
//  Created by Chieh on 10/11/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class RollingRockB: SpaceshipActor{
    
   // fileprivate var _initialPosition:CGPoint;
    //var Sprite:SpriteActor { get{return self.Spaceship}}
    
    fileprivate var _acceleration: CGFloat;
    
    init(position:CGPoint)
    {
        self._acceleration = GeneralGameSettings.ROLLINGROCKB_ACC;
        super.init(imageName: GeneralGameSettings.ROLLINGROCKB_NAME, explosionName: GeneralGameSettings.EXPLOSIONC_NAME, health: GeneralGameSettings.ROLLINGROCKB_HEALTH, speed: GeneralGameSettings.ROLLINGROCKB_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship,  point: GeneralGameSettings.ROLLINGROCKB_POINT, isSpaceShipAnimation: true);
        
    }
    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self._acceleration += GeneralGameSettings.ROLLINGROCKB_ACC;
            self.Spaceship.position.y -= (self.Speed + self._acceleration);
        }
        else{
            self._acceleration = 0;
        }
    }
    
}
