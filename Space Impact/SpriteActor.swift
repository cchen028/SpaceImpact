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
    private var _spriteAction: SKAction!;
    private var _spriteTextures: [SKTexture];
    
    var Sprite:SKSpriteNode{get{return _sprite}}
    
    var Scale:CGFloat { get{return self._scale} set{self._scale = Scale; self._sprite.xScale = Scale;self._sprite.yScale = Scale}}
    var Position:CGPoint{get{return self._sprite.position} set{self._position = Position; self._sprite.position = Position}}
    var Width:CGFloat{get{return self._width}}
    var Height:CGFloat{get{return self._height}}
    var ActualWidth:CGFloat{get{return self._width * self._scale}}
    var ActualHeight:CGFloat{get{return (self._height) * self._scale}}
    var Opacity:CGFloat{get{return self._opacity} set(val){self._opacity = val; self._sprite.alpha = val}}
    var SpriteAction:SKAction{get{return self._spriteAction} set(val){self._spriteAction = val}}
    
    init(imageName:String,position:CGPoint, scale:CGFloat, opacity:CGFloat, atlasName:String = "", repeatCount:Int = -1)
    {
        self._sprite = SKSpriteNode(imageNamed:imageName);
        self._position = position;
        self._scale = scale;
        self._width = self._sprite.frame.size.width;
        self._height = self._sprite.frame.size.height;
        
        self._sprite.position = self._position;
        self._sprite.xScale = self._scale;
        self._sprite.yScale = self._scale;
        self._sprite.alpha = opacity;
        self._opacity = opacity;
        self._spriteTextures = [SKTexture]();
        
        if(atlasName != ""){
            
            let atlas = SKTextureAtlas(named:atlasName);
            
            for (var i = 1; i <= 30; i++){
                self._spriteTextures.append(atlas.textureNamed(self.getFileName(atlasName, orderNumber: i)));
            }
            
            let anim = SKAction.animateWithTextures(
                self._spriteTextures, timePerFrame: 0.05);
            
            if(repeatCount == -1)
            {
                self._spriteAction = SKAction.repeatActionForever(anim);
            }
            else
            {
                self._spriteAction = SKAction.repeatAction(anim, count: repeatCount);
            }
            
            self._sprite.runAction(self._spriteAction);

        }
        else
        {
            self._spriteAction = SKAction();
        }

    }
    
    convenience init(sprite:SKSpriteNode, position:CGPoint){
        self.init(sprite:sprite,position:position,scale:0.1, opacity:0);
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
        self._spriteTextures = [SKTexture]();
    
    }
    
    private func getFileName(name:String, orderNumber:Int) -> String{
        var fileName:String = name + "_";
        if orderNumber < 10 {
            fileName += ("0" + String(orderNumber));
        }
        else
        {
            fileName += String(orderNumber);
            
        }
        
        return fileName;
    }
    
}


enum ActorType:Int{
    case MySpaceship = 1, RollingAstroid_A, StraightRock, EnemySpaceship
    
}
