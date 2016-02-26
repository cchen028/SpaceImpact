//
//  Spaceship.swift
//  Space Impact
//
//  Created by Chieh on 2/19/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Spaceship: SpriteActor{
    
    private var _health:Int;
    private var _speed:Int;
    private var _damage:Int;
    private var _type:ActorType;
    
    var Health:Int{get{return _health} set(newVal){_health = newVal}};
    var Speed:Int{get{return _speed} set(newVal){_speed = newVal}};
    var Damage:Int{get{return _damage} set(newVal){_damage = newVal}};
    var Type:ActorType{get{return _type} set(newVal){_type = newVal}};
    
    init(type:ActorType)
    {
        switch(type)
        {
            case ActorType.MySpaceship:
                _health = 1;
                _speed = 8;
                _damage = 1;
                _type = type;
            default:
                _health = 1;
                _speed = 8;
                _damage = 1;
                _type = type;
        }
        
        super.init(type: type,scale: 0.1);
        
        
    }
    
    private func InitializeSpaceship(type:ActorType){
        
    }
    
    
}
