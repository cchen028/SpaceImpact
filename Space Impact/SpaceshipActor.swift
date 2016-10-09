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
    
    fileprivate var _health:Int;
    fileprivate var _speed:CGFloat;
    fileprivate var _damage:Int;
    fileprivate var _isCollide:Bool;
    fileprivate var _spaceship:SpriteActor;
    fileprivate var _spaceshipMissleTimer: Timer!;
    
    
    internal var _missleTimer:MissleTimer;
    internal var _explosion:SpriteActor;
    internal var _missles:[Missle];
    
    var Health:Int{get{return _health} set(newVal){_health = newVal}};
    var Speed:CGFloat{get{return _speed} set(newVal){_speed = newVal}};
    var Damage:Int{get{return _damage} set(newVal){_damage = newVal}};
    var Explosion:SpriteActor{get{return _explosion} set(newVal){_explosion = newVal}};
    var IsCollide:Bool{get{return _isCollide} set(newVal){_isCollide = newVal;collideUpdate(self._spaceship.IsActive)}};
    var IsActive:Bool{get{return self._spaceship.IsActive} set(newVal){self._spaceship.IsActive = newVal}};
    var Spaceship:SpriteActor{get{return self._spaceship}};
    var Missles:[Missle]{get{return self._missles}};
    var `Type`:ActorType{get{return self._spaceship.Type}};

    init(imageName:String, explosionName: String, health:Int, speed:CGFloat, damage:Int , position:CGPoint,scale:CGFloat = 1,type:ActorType, isSpaceShipAnimation:Bool = false)
    {
        self._missleTimer = MissleTimer();
        self._missles = [Missle]();
        
        _health = health;
        _speed = speed;
        _damage = damage;
        _isCollide = false;
        _explosion = SpriteActor(atlasName:explosionName, position: position, scale: 1, opacity: 1, frameCount: 1, type:ActorType.Explosion, repeatCount: 1, startAnimating: false);
        
        if(isSpaceShipAnimation)
        {
            _spaceship = SpriteActor(atlasName: imageName, position: position, scale: 1, opacity: 1,frameCount: 1 , type:type, startAnimating: true);
        }
        else
        {
            _spaceship = SpriteActor(imageName: imageName, position: position, scale: scale, opacity: 1, type:type);
        }
        
        let uniqueID = UUID().uuidString;
        self._explosion.name = ActorType.Explosion.rawValue + "_" + uniqueID ;
        self._spaceship.name = uniqueID;
        
        super.init();
    }
    
    func SetActive(_ isActive:Bool){
        if(self.IsActive != isActive){
            UpdateStatus(isActive);
        }
        
        self._spaceship.SetActive(isActive);
        
        
        self._explosion.SetActive(isActive);
    }
    
    func Update(){
        self._explosion.position = self._spaceship.position;
    }
    
    func UpdateStatus(_ isActive: Bool){
        self._spaceship.alpha = isActive ? 1 : 0;
        self._explosion.alpha = isActive ? 0 : 1;
    }
    
    func Explode(){
       // self._spaceship.alpha = 0;
        //self._explosion.alpha = 1;
        self._spaceship.SetActive(false);
        self._explosion.RunAnimation();
       // self._explosion.run(self._explosion.SpriteAction, completion: {self._explosion.SetActive(false); self._spaceship.removeFromParent()});
    }
    
    func AddMissle() {
        for i in 0...(_missles.count - 1){
            if(!_missles[i].IsActive){
                _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2));
                _missles[i].SetActive(true);
                break;
            }
        }
    }
    
    func StopMissle(){
        for i in 0...(_missles.count - 1){
            if(_missles[i].IsActive){
                _missles[i].SetActive(false);
                break;
            }
        }
    }
    
    fileprivate func collideUpdate(_ isCollided:Bool){
        if isCollided{
        }
    }
}
