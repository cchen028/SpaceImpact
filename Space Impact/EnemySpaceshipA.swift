//
//  EnemySpaceshipA.swift
//  Space Impact
//
//  Created by Chieh on 3/6/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class EnemySpaceshipA: SpaceshipActor{

    
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    init(position:CGPoint)
    {
       // self._initialPosition = position;
        
        super.init(imageName: GeneralGameSettings.ENEMYA_NAME, explosionName: GeneralGameSettings.ENEMYA_EXPLOSION, health: GeneralGameSettings.ENEMYA_HEALTH, speed: GeneralGameSettings.ENEMYA_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship,  point: GeneralGameSettings.ENEMYA_POINT, isSpaceShipAnimation: false);
        
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for _ in 1...25{
            self._missles.append(Missle(position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type: ActorType.EnemyMissle));
        }
    }
    
    override func AddMissle() {
        super.AddMissle();
    }
    
    override func StopMissle(){
        super.StopMissle();
    }
    
    
    fileprivate func misslesUpdate(){
        if self._missles.count > 0{
            for mIndex in 0...(self._missles.count - 1){
                self._missles[mIndex].Update();
            }
        }
    }
    
    override func SetActive(_ isActive:Bool){
        self._missleTimer.ToggleMissleTimer(isOn: isActive, targetSpaceship: self, missleFz: GeneralGameSettings.ENEMYA_Missle_Frequency);

        super.SetActive(isActive);
    }


    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self.Spaceship.position.y -= 2;
        }
    }
    
}

