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
            self._spaceship.Explode();
        }
    }
}
