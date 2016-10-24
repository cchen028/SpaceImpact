//
//  CollidingServices.swift
//  Space Impact
//
//  Created by Chieh on 9/21/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation


class CollidingServices {
    
    fileprivate var _level:LevelClass;
    fileprivate var _spaceship:Spaceship;
    
    init(level:LevelClass, spaceship:Spaceship){
        self._level = level;
        self._spaceship = spaceship;
    }
    
    func Update(){
        mySpaceshipCollisionUpdate();
    }
    
    fileprivate func mySpaceshipCollisionUpdate(){
        
        if(self._spaceship._missles.count <= 0)
        {
            return;
        }
        
        let spaceObjects = self._level.Enemies;
        for mIndex in 0...(self._spaceship._missles.count - 1)	{
            for eachNode in (spaceObjects){
                if let spaceshipActor = eachNode as? SpaceshipActor{
                    if(spaceshipActor.Type == ActorType.EnemySpaceship && spaceshipActor.IsActive)
                    {
                        self.missleCollideUpdate(spaceshipActor, missleIndex:mIndex);
                        self.selfCollideUpdate(spaceActor: spaceshipActor);
                    }
                }
            }
        }
        
        let items = self._level.Items;
        
        for eachItem in items{
            self.itemCollideUpdate(eachItem);
        }
    }
    
    fileprivate func itemCollideUpdate(_ item: ItemActor){
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
            default:
                break;
            }
            
            UserStatsInfo.instance.Score.value += item.Point;
        }
    }
    
    fileprivate func missleCollideUpdate(_ actor: SpaceshipActor, missleIndex:Int){
        let collided = self._spaceship._missles[missleIndex].IsCollidedWith(actor);
        
        if(collided)
        {
            self._spaceship._missles[missleIndex].SetActive(false);
            actor.Explode();
            UserStatsInfo.instance.Score.value += actor.Point;
        }
    }
    
    fileprivate func selfCollideUpdate(spaceActor: SpaceshipActor){
        let collided = self._spaceship.IsCollidedWith(spaceActor);
        
        if(collided)
        {
            spaceActor.Explode();
            self._spaceship.Health = max(1, self._spaceship.Health - 1);
        }
    }
}
