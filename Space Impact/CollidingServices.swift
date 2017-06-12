//
//  CollidingServices.swift
//  Space Impact
//
//  Created by Chieh on 9/21/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class CollidingServices {
    
    fileprivate var _level:LevelActor;
    fileprivate var _spaceship:Spaceship;
    
    init(level:LevelActor, spaceship:Spaceship){
        self._level = level;
        self._spaceship = spaceship;
    }
    
    func Update(){
        myMisslesCollidesEnemyUpdate();
        enemyMisslesCollidesMeUpdate();
        enemyCollidesMeUpdate();
        itemCollideUpdate();
    }
    
    
    fileprivate func myMisslesCollidesEnemyUpdate(){
        let spaceObjects = self._level.Enemies;
        
        if(self._spaceship._missles.count <= 0)
        {
            return;
        }
        
        for eachNode in (spaceObjects){
            if let spaceshipActor = eachNode as? SpaceshipActor{
                if((spaceshipActor.Type == ActorType.EnemySpaceship || spaceshipActor.Type == ActorType.Beacon) && spaceshipActor.IsActive)
                {
                    
                    if(self._spaceship.IsBigLazer){
                        spaceshipDamageHitUpdate(actor: spaceshipActor, damagePosition: spaceshipActor.Position, damage: 2);
                    }
                    
                    for mIndex in 0...(self._spaceship._missles.count - 1)	{
                        
                        let missle = self._spaceship._missles[mIndex];
                        let collided = missle.IsCollidedWith(spaceshipActor);
                        
                        if(collided)
                        {
                            missle.SetActive(false);
                            spaceshipDamageHitUpdate(actor: spaceshipActor, damagePosition: missle.Position, damage: (Int)(missle.Damage));
                        }
                    }
                }
            }
        }
        self._spaceship.IsBigLazer = false;
    }
    
    fileprivate func enemyMisslesCollidesMeUpdate(){
        
        let spaceObjects = self._level.Enemies;
        for eachNode in (spaceObjects){
            
            if let spaceshipActor = eachNode as? SpaceshipActor{
                if((spaceshipActor.Type == ActorType.EnemySpaceship || spaceshipActor.Type == ActorType.Beacon) && spaceshipActor.IsActive && spaceshipActor._missles.count > 0)
                {
                    for mIndex in 0...(spaceshipActor._missles.count - 1)	{
                        let missle = spaceshipActor._missles[mIndex];
                        let collided = missle.IsCollidedWith(self._spaceship);
                        
                        if(collided)
                        {
                            missle.SetActive(false);
                            spaceshipDamageHitUpdate(actor: self._spaceship, damagePosition: missle.Position, damage: (Int)(missle.Damage));
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func enemyCollidesMeUpdate(){
        
        let spaceObjects = self._level.Enemies;
        for eachNode in (spaceObjects){
                if let spaceshipActor = eachNode as? SpaceshipActor{
                    let collided = self._spaceship.IsCollidedWith(spaceshipActor);
                    if(collided && (spaceshipActor.Type == ActorType.EnemySpaceship || spaceshipActor.Type == ActorType.Beacon) && spaceshipActor.IsActive)
                    {
                        spaceshipDamageHitUpdate(actor: spaceshipActor, damagePosition: self._spaceship.Position, damage: 2);
                        spaceshipDamageHitUpdate(actor: self._spaceship, damagePosition: self._spaceship.Position, damage: 1);
                    }
                }
        }
        
    }
    
    fileprivate func itemCollideUpdate(){
        let items = self._level.Items;
        
        
        for item in items{
            let collided = self._spaceship.IsCollidedWith(item);
            
            if(collided)
            {
                item.Explode();
                
                switch(item.Item.Type){
                case .ItemHeart:
                    UserStatsInfo.instance.Life.value = min(5, UserStatsInfo.instance.Life.value + 1);
                    break;
                case .ItemShield:
                    self._spaceship.Health = min(4, self._spaceship.Health + 1);
                    break;
                case .ItemLightning:
                    if UserStatsInfo.instance.Bomb.value < 5{
                        UserStatsInfo.instance.Bomb.value += 1;
                    }
                    break;
                case .ItemMissleUpgrade:
                    let newType = self._spaceship.MyMissleType == ActorType.MyMissle ? ActorType.MyMissleSpeed : ActorType.MyMissleTriple;
                    self._spaceship.SetMissleType(missleType: newType);
                    break;
                default:
                    break;
                }
                
                UserStatsInfo.instance.Score.value += item.Point;
            }
        }
    }
    
    fileprivate func spaceshipDamageHitUpdate(actor: SpaceshipActor, damagePosition:CGPoint, damage:Int){
        actor.Health = actor.Health - damage;
        if(actor.Health < 1){
            if(actor.Type == .Beacon){
                let beacon = actor as! BeaconB;
                beacon.Explode();
                UserStatsInfo.instance.Score.value += actor.Point;
                _level.SpawnItem(position: actor.Position, itemIndex: GameObjectServices.instance.GetRandomNumber(endRange: 4, zeroBase: true));
            }
            
            if(actor.Type == .EnemySpaceship){
                actor.Explode();
                UserStatsInfo.instance.Score.value += actor.Point;
            }
            
            if(actor.Type == .MySpaceship && !self._spaceship.IsInvincible){
                mySpaceshipDamageHitUpdate(damage: damage);
            }
        }
        else{
            actor.Injure(position: damagePosition);
        }
    }
    
    fileprivate func mySpaceshipDamageHitUpdate(damage:Int){
        let curHealthLeft = self._spaceship.Health - damage;
        if(curHealthLeft < 1){
            self._spaceship.Explode();
            UserStatsInfo.instance.Life.value -= 1;
            self._spaceship.Respawn();
        }
        else{
            self._spaceship.Health = curHealthLeft;
        }
    }
}
