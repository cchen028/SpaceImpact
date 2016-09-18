//
//  RollingRockA.swift
//  Space Impact
//
//  Created by Chieh on 3/6/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class RollingRockA: SpaceshipActor, IActor{
    
    fileprivate var _initialPosition:CGPoint;
    fileprivate var _gameScene:GameScene;
    
    
    var Position:CGPoint{get{return self.Spaceship.position}}
    var IsActive:Bool{get{return self.Spaceship.IsActive} set(newVal){self.Spaceship.IsActive = newVal}};
    var Sprite:SpriteActor { get{return self.Spaceship}}
   // private var _missles:[Missle];
   // private var _moveDirection:MoveDirection;
    
    //private var _frameCount:CGFloat;
    
  //  var Missles:[Missle]{get{return self._missles}};
  //  var Direction:MoveDirection{get{return self._moveDirection} set(val){self._moveDirection = val}}
    
    init(gs:GameScene, position:CGPoint)
    {
        self._gameScene = gs;
        self._initialPosition = position;

        super.init(gs: gs, imageName: GeneralGameSettings.ROLLINGROCKA_NAME, explosionName: GeneralGameSettings.ROLLINGROCKA_EXPLOSION, health: GeneralGameSettings.ROLLINGROCKA_HEALTH, speed: GeneralGameSettings.ROLLINGROCKA_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship, isSpaceShipAnimation: true);
        
       // self._gameScene.addSpaceship(self);
    }

    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self.Spaceship.position.y -= self.Speed;
        }
        
    }
    
    func SetActive(_ isActive:Bool){
        if(self.IsActive == isActive)
        {
            return;
        }
        else{
            self.IsActive = isActive;
        }
        
        if(isActive){
            Active();
        }
        else
        {
           Explode();
          //  InActive();
        }
    }
    
    override func Active() {
        super.Active();
    }
    
    override func InActive() {
       // super.Explode();
        super.InActive();
    }
    
    override func Explode() {
        super.Explode();
     //   self._explosion.RunAnimation();
        
    }
    
   
}
