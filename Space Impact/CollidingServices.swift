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
        MySpaceshipCollisionUpdate();
    }
    
    fileprivate func MySpaceshipCollisionUpdate(){
        
        if(self._spaceship._missles.count <= 0)
        {
            return;
        }
        
        let spaceObjects = self._level.Enemies;
        for mIndex in 0...(self._spaceship._missles.count - 1)	{
            for eachNode in (spaceObjects){
                if let spaceshipActor = eachNode as? SpaceshipActor{
                    if(spaceshipActor.Type == ActorType.EnemySpaceship)
                    {
                        self.MissleCollideUpdate(spaceshipActor, missleIndex:mIndex);
                        self.SelfCollideUpdate(spaceActor: spaceshipActor);
                    }
                }
            }
        }
    }
    
    fileprivate func MissleCollideUpdate(_ actor: SpaceshipActor, missleIndex:Int){
        let collided = self._spaceship._missles[missleIndex].IsCollidedWith(actor);
        
        if(collided)
        {
            self._spaceship._missles[missleIndex].SetActive(false);
            actor.Explode();
            UserStatsInfo.instance.Score.value += actor.Point;
        }
    }
    
    fileprivate func SelfCollideUpdate(spaceActor: SpaceshipActor){
        let collided = self._spaceship.IsCollidedWith(spaceActor);
        
        if(collided)
        {
            spaceActor.Explode();
            self._spaceship.Explode();
        }
    }
    
    fileprivate func IsCollideWithSelf(_ actor: SpaceshipActor) -> Bool{
        return actor.Spaceship.IsActive && self._spaceship.Spaceship.frame.intersects(actor.Spaceship.frame);
    }
}
