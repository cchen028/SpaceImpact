//
//  Actor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

 class SpriteActor: IActor {
    
    private var _sprite:SKSpriteNode;
    private var _scale:CGFloat;
    private var _position:CGPoint;
    private var _width:CGFloat;
    private var _height:CGFloat;
    private var _opacity:CGFloat;
    
    var Sprite:SKSpriteNode{get{return _sprite}}
    
    var Scale:CGFloat { get{return self._scale} set{self._scale = Scale; self._sprite.xScale = Scale;self._sprite.yScale = Scale}}
    var Position:CGPoint{get{return self._position} set{self._position = Position; self._sprite.position = Position}}
    var Width:CGFloat{get{return self._width}}
    var Height:CGFloat{get{return self._height}}
    var ActualWidth:CGFloat{get{return self._width * self._scale}}
    var ActualHeight:CGFloat{get{return (self._height) * self._scale}}
    var Opacity:CGFloat{get{return self._opacity}}
    
    init(type:ActorType, scale:CGFloat)
    {
        
        switch(type)
        {
        case ActorType.MySpaceship:
            let location = CGPoint(x:300, y:50);
            self._sprite = SKSpriteNode(imageNamed:"Spaceship");
            self._position = location;
            
       //     self.init(sprite: SKSpriteNode(imageNamed:"Spaceship"),position: location,scale:0.1);
        default:
            let location = CGPoint(x:300, y:50);
            self._sprite = SKSpriteNode(imageNamed:"Spaceship");
            self._position = location;
        //    self.init(sprite: SKSpriteNode(imageNamed:"Spaceship"),position: location,scale:0.1);
        }
     
        self._scale = scale;
        self._width = self._sprite.frame.size.width;
        self._height = self._sprite.frame.size.height;
        
        self._sprite.position = self._position;
        self._sprite.xScale = self._scale;
        self._sprite.yScale = self._scale;
        self._opacity = 1;

    }
    
    convenience init(sprite:SKSpriteNode, position:CGPoint){
        self.init(sprite:sprite,position:position,scale:0, opacity:1);
    }
    
    init(sprite:SKSpriteNode, position:CGPoint, scale:CGFloat, opacity:CGFloat){
        self._sprite = sprite;
        self._position = position;
        self._scale = scale;
        self._width = sprite.frame.size.width;
        self._height = sprite.frame.size.height;
        self._opacity = opacity;
        
        self._sprite.position = position;
        self._sprite.xScale = scale;
        self._sprite.yScale = scale;
        self._sprite.alpha = self._opacity;
    
    }
    
}


enum ActorType:Int{
    case MySpaceship = 1, RollingRock, StraightRock, EnemySpaceship
    
}
