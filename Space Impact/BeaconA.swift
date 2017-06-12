//
//  BeaconA.swift
//  Space Impact
//
//  Created by Chieh on 5/27/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class BeaconA: SpaceshipActor{
    
    fileprivate var _initialPosition:CGPoint;
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    init(position:CGPoint)
    {
        self._initialPosition = position;
        
        super.init(imageName: GeneralGameSettings.BEACONA_NAME, explosionName: GeneralGameSettings.BEACONA_EXPLOSION, health: GeneralGameSettings.BEACONA_HEALTH, speed: GeneralGameSettings.BEACONA_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship,  point: GeneralGameSettings.ROLLINGROCKA_POINT, isSpaceShipAnimation: true);
        
    }
    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self.Spaceship.position.y -= self.Speed;
        }
    }
}
