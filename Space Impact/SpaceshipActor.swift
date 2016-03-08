//
//  SpaceshipActor.swift
//  Space Impact
//
//  Created by Chieh on 3/5/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class SpaceshipActor: SpriteActor{
    
    private var _health:Int;
    private var _speed:CGFloat;
    private var _damage:Int;
    private var _type:ActorType;
    private var _explosion:SpriteActor;
    private var _isActive:Bool;
    private var _isCollide:Bool;
    
    var Health:Int{get{return _health} set(newVal){_health = newVal}};
    var Speed:CGFloat{get{return _speed} set(newVal){_speed = newVal}};
    var Damage:Int{get{return _damage} set(newVal){_damage = newVal}};
    var Type:ActorType{get{return _type} set(newVal){_type = newVal}};
    var Explosion:SpriteActor{get{return _explosion} set(newVal){_explosion = newVal}};
    var IsActive:Bool{get{return _isActive} set(newVal){_isActive = newVal;}};
    var IsCollide:Bool{get{return _isCollide} set(newVal){_isCollide = newVal;collideUpdate(_isActive)}};

    
    init(type:ActorType, position:CGPoint)
    {
        switch(type)
        {
        case ActorType.MySpaceship:
            _health = 1;
            _speed = GeneralGameSettings.MYSPACESHIP_SPEED;
            _damage = 1;
            _type = type;
            _isActive = true;
            _isCollide = false;
            _explosion = SpriteActor(imageName: GeneralGameSettings.MYSPACESHIP_NAME, position: position, scale: 0.5, opacity: 0);
            super.init(imageName: GeneralGameSettings.MYSPACESHIP_NAME, position: position, scale: 0.5, opacity: 0);
            break;
        case ActorType.RollingAstroid_A:
            _health = 1;
            _speed = GeneralGameSettings.MYSPACESHIP_SPEED;
            _damage = 1;
            _type = type;
            _isActive = true;
            _isCollide = false;
            _explosion = SpriteActor(imageName: GeneralGameSettings.ROLLINGROCKA_NAME + "_01.png",position: position, scale: 1, opacity: 0);
            super.init(imageName: GeneralGameSettings.ROLLINGROCKA_NAME + "_01.png",position: position, scale: 1, opacity: 1, atlasName: GeneralGameSettings.ROLLINGROCKA_NAME);
            break;
        default:
            _health = 1;
            _speed = 8;
            _damage = 1;
            _type = type;
            _isActive = true;
            _isCollide = false;
            _explosion = SpriteActor(imageName: "error", position: position, scale: 0.5, opacity: 0);
            super.init(imageName: "error",position: position, scale: 0.5, opacity: 0);
        }
        
        
        
        
        
    }
    
    func Update(){
        
    }
    
    private func collideUpdate(isCollided:Bool){
        if isCollided{
            _explosion = SpriteActor(imageName: GeneralGameSettings.ROLLINGROCKA_NAME + "_01.png",position: self.Position, scale: 1, opacity: 1, atlasName: GeneralGameSettings.ROLLINGROCKA_NAME, repeatCount: 1);

        }
    }
}
