//
//  SpaceshipActor.swift
//  Space Impact
//
//  Created by Chieh on 3/5/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class SpaceshipActor: NSObject, ISpaceship{
    
    //var _isActive:Bool;
    
    fileprivate var _health:Int;
    fileprivate var _speed:CGFloat;
    fileprivate var _damage:Int;
    var _explosion:SpriteActor;
    fileprivate var _isCollide:Bool;
    fileprivate var _spaceship:SpriteActor;
    fileprivate var _spaceshipMissleTimer: Timer!;
    fileprivate var _gameScene:GameScene;
    
    var _missleTimer:MissleTimer;
    var _missles:[Missle];
    
    var Health:Int{get{return _health} set(newVal){_health = newVal}};
    var Speed:CGFloat{get{return _speed} set(newVal){_speed = newVal}};
    var Damage:Int{get{return _damage} set(newVal){_damage = newVal}};
    var Explosion:SpriteActor{get{return _explosion} set(newVal){_explosion = newVal}};
    var IsCollide:Bool{get{return _isCollide} set(newVal){_isCollide = newVal;collideUpdate(self._spaceship.IsActive)}};
    var Spaceship:SpriteActor{get{return self._spaceship}};
    var Missles:[Missle]{get{return self._missles}};

    init(gs:GameScene, imageName:String, explosionName: String, health:Int, speed:CGFloat, damage:Int , position:CGPoint,scale:CGFloat = 1,type:ActorType, isSpaceShipAnimation:Bool = false)
    {
        self._gameScene = gs;
        self._missleTimer = MissleTimer();
        self._missles = [Missle]();
        
        _health = health;
        _speed = speed;
        _damage = damage;
      //  _isActive = false;
        _isCollide = false;
        _explosion = SpriteActor(gs:gs, atlasName:explosionName, position: position, scale: 1, opacity: 1, frameCount: 1, type:ActorType.Explosion, repeatCount: 1, startAnimating: false);
        
        if(isSpaceShipAnimation)
        {
            _spaceship = SpriteActor(gs:gs, atlasName: imageName, position: position, scale: 1, opacity: 1,frameCount: 1 , type:type, startAnimating: true);
        }
        else
        {
            _spaceship = SpriteActor(gs:gs, imageName: imageName, position: position, scale: scale, opacity: 1, type:type);
            
        }
        
        let uniqueID = UUID().uuidString;
         self._explosion.name = ActorType.Explosion.rawValue + "_" + uniqueID ;
        self._spaceship.name = uniqueID;
        
      //  self._spaceship.physicsBody = SKPhysicsBody(rectangleOfSize: self._spaceship.frame.size);
      //  self._spaceship.physicsBody?.usesPreciseCollisionDetection = true;
        //self._spaceship.physicsBody?.
     //   self._spaceship.physicsBody?.categoryBitMask = GeneralGameSettings.ENEMY_CATEGORY;
        
        super.init();
    }
    
    func Update(){
        self._explosion.position = self._spaceship.position;
    }
    
    func Explode(){
        self._spaceship.alpha = 0;
        self._explosion.alpha = 1;
     //   self._explosion.RunAnimation();
        

            // self.runAction(self._spriteAction);
        self._explosion.run(self._explosion.SpriteAction, completion: {self._explosion.removeFromParent(); self._spaceship.removeFromParent()});

    }
    
    func Active(){
      //  self._gameScene.childNodeWithName(GeneralGameSettings.GAMESCREEN_NAME)?.addChild(self._spaceship);
        self._spaceship.alpha = 1;
        self._explosion.alpha = 0;
        self._spaceship.Active();
        self._explosion.Active();
      //  self._gameScene.childNodeWithNodeType(NodeType.GameScreen)?.addChild(self._spaceship);
    //    self._gameScene.childNodeWithNodeType(NodeType.GameScreen)?.addChild(self._explosion);
        
    }
    
    func InActive() {
        self._spaceship.removeAllActions();
        self._spaceship.removeAllChildren();
        self._spaceship.removeFromParent();
        
        self._explosion.removeAllActions();
        self._explosion.removeAllChildren();
        self._explosion.removeFromParent();
     //   self._spaceship = nil;
     //   self._explosion
      //  self._spaceship.position = CGPoint(x:900,y:900);
      //  self._explosion.position = self._spaceship.position;
    }
    
    func AddMissle() {
    }
    
    func IsCollideWithSelf(_ actor: SpriteActor) -> Bool{
        return self.Spaceship.frame.intersects(actor.frame);
    }
    
    
    
    fileprivate func collideUpdate(_ isCollided:Bool){
        if isCollided{
        }
    }
}
