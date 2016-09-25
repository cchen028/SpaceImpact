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
        
        let spaceObjects = GameObjectServices.instance.GameScreen!;
        for mIndex in 0...(self._spaceship._missles.count - 1)	{
            for eachNode in (spaceObjects.children){
                if let spriteNode = eachNode as? SpriteActor{
                    if(spriteNode.Type == ActorType.EnemySpaceship)
                    {
                        self.MissleCollideUpdate(spriteNode, missleIndex:mIndex);
                        self.SelfCollideUpdate(spaceActor: spriteNode);
                    }
                }
            }
        }
    }

    fileprivate func MissleCollideUpdate(_ actor: SpriteActor, missleIndex:Int){
        let collided = self._spaceship._missles[missleIndex].IsCollideWithSelf(actor);
        
        if(collided)
        {
            self._spaceship._missles[missleIndex].SetActive(false);
            actor.SetActive(false);
            
            if let explosionActor = GameScene.instance!.childNode(withName: GeneralGameSettings.GAMESCREEN_NAME)!.childNode(withName: ActorType.Explosion.rawValue+"_"+actor.name!) as? SpriteActor
            {
                explosionActor.Explode();
            }
        }
    }
    fileprivate func SelfCollideUpdate(spaceActor: SpriteActor){
        let collided = self.IsCollideWithSelf(spaceActor);
        
        if(collided)
        {
            //self._spaceship.SetActive(false);
            //self.SetActive(false);
          //  spaceActor.SetActive(false);
            
            spaceActor.Explode();
            self._spaceship.Explode();
        }
    }
    
    fileprivate func IsCollideWithSelf(_ actor: SpriteActor) -> Bool{
        return self._spaceship.Sprite.frame.intersects(actor.frame);
    }
}
