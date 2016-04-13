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
    
    var _isActive:Bool;
    
    private var _health:Int;
    private var _speed:CGFloat;
    private var _damage:Int;
    var _explosion:SpriteActor;
    private var _isCollide:Bool;
    private var _spaceship:SpriteActor;
    private var _spaceshipMissleTimer: NSTimer!;
    private var _gameScene:GameScene;
    
    var _missleTimer:MissleTimer;
    var _missles:[Missle];
    
    var Health:Int{get{return _health} set(newVal){_health = newVal}};
    var Speed:CGFloat{get{return _speed} set(newVal){_speed = newVal}};
    var Damage:Int{get{return _damage} set(newVal){_damage = newVal}};
    var Explosion:SpriteActor{get{return _explosion} set(newVal){_explosion = newVal}};
    var IsCollide:Bool{get{return _isCollide} set(newVal){_isCollide = newVal;collideUpdate(_isActive)}};
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
        _isActive = false;
        _isCollide = false;
        _explosion = SpriteActor(gs:gs, atlasName:explosionName, position: position, scale: 1, opacity: 0, frameCount: 1, type:type, repeatCount: 1, startAnimating: false);
        
        if(isSpaceShipAnimation)
        {
            _spaceship = SpriteActor(gs:gs, atlasName: imageName, position: position, scale: 1, opacity: 1,frameCount: 1 , type:type, startAnimating: true);
        }
        else
        {
            _spaceship = SpriteActor(gs:gs, imageName: imageName, position: position, scale: scale, opacity: 1, type:type);
            
        }
        
      //  self._spaceship.physicsBody = SKPhysicsBody(rectangleOfSize: self._spaceship.frame.size);
      //  self._spaceship.physicsBody?.usesPreciseCollisionDetection = true;
        //self._spaceship.physicsBody?.
     //   self._spaceship.physicsBody?.categoryBitMask = GeneralGameSettings.ENEMY_CATEGORY;
        
        super.init();
    }
    
    func Update(){
        
    }
    
    func Active(){
      //  self._gameScene.childNodeWithName(GeneralGameSettings.GAMESCREEN_NAME)?.addChild(self._spaceship);
        self._gameScene.childNodeWithNodeType(NodeType.GameScreen)?.addChild(self._spaceship);
        
    }
    
    func InActive() {
        self._spaceship.removeFromParent();
    
        self._spaceship.position = CGPoint(x:900,y:900);
    }
    
    func AddMissle() {
    }
    
    func IsCollideWithSelf(actor: SpriteActor) -> Bool{
        return self.Spaceship.frame.intersects(actor.frame);
    }
    
    
    
    private func collideUpdate(isCollided:Bool){
        if isCollided{
        }
    }
}
