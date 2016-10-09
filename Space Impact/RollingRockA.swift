//
//  RollingRockA.swift
//  Space Impact
//
//  Created by Chieh on 3/6/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class RollingRockA: SpaceshipActor, IActor{
    
    fileprivate var _initialPosition:CGPoint;
    var Position:CGPoint{get{return self.Spaceship.position}}
   // var IsActive:Bool{get{return self.Spaceship.IsActive} set(newVal){self.Spaceship.IsActive = newVal}};
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    init(position:CGPoint)
    {
        self._initialPosition = position;

        super.init(imageName: GeneralGameSettings.ROLLINGROCKA_NAME, explosionName: GeneralGameSettings.ROLLINGROCKA_EXPLOSION, health: GeneralGameSettings.ROLLINGROCKA_HEALTH, speed: GeneralGameSettings.ROLLINGROCKA_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship, isSpaceShipAnimation: true);
        
    }

    
    
    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self.Spaceship.position.y -= self.Speed;
        }
        
    }
    
    override func SetActive(_ isActive:Bool){
//        if(self.IsActive != isActive){
//            UpdateStatus(isActive);
//        }
//        self.IsActive = isActive;
        
        super.SetActive(isActive);
    }
    
//    override func UpdateStatus(_ isActive: Bool){
//       super.UpdateStatus(isActive);
//    }
    
    override func Explode() {
        super.Explode();
        
    }
    
   
}
