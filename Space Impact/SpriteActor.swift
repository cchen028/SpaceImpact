//
//  Actor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

 class SpriteActor: SKSpriteNode {
    
    private var _spriteAction: SKAction!;
    private var _spriteTextures: [SKTexture];
    private var _isAnimation:Bool;
    private var _gameScene:GameScene?;
    private var _type:ActorType;
    
    var Width:CGFloat{get{return self.frame.width}}
    var Height:CGFloat{get{return self.frame.height}}
    var SpriteAction:SKAction{get{return self._spriteAction} set(val){self._spriteAction = val}}
    var Type:ActorType{get{return _type} set(newVal){_type = newVal}};
    
    init(gs:GameScene, imageName:String,position:CGPoint, scale:CGFloat, opacity:CGFloat,type:ActorType)
    {
        self._gameScene = gs;
        self._isAnimation = false;
        self._spriteTextures = [SKTexture]();
        self._type = type;
        
        let texture = gs.AssetService?.SKTextures[imageName];
        super.init(texture: texture, color: UIColor.clearColor(), size: texture!.size());
        
        self.position = position;
        self.xScale = scale;
        self.yScale = scale;
        self.alpha = opacity;

    }
    
    init(gs:GameScene, atlasName:String,position:CGPoint, scale:CGFloat, opacity:CGFloat, frameCount:Int, type:ActorType , repeatCount:Int = -1, startAnimating:Bool = false)
    {
        self._gameScene = gs;
        self._isAnimation = true;
        self._spriteTextures = [SKTexture]();
        self._type = type;
        
        let texture = gs.AssetService?.SKTextures[atlasName];
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture!.size());
        
        self.position = position;
        self.xScale = scale;
        self.yScale = scale;
        self.alpha = opacity;
        
        self._spriteTextures = (gs.AssetService?.SKTexturesList[atlasName])!;
        
        let anim = SKAction.animateWithTextures(self._spriteTextures, timePerFrame: 0.05);
        
        if(repeatCount == -1)
        {
            self._spriteAction = SKAction.repeatActionForever(anim);
        }
        else
        {
            self._spriteAction = SKAction.repeatAction(anim, count: repeatCount);
        }
        
        if(startAnimating){
            self.runAction(self._spriteAction);
        }
    }

    required init?(coder aDecoder: NSCoder) {
        self._gameScene = nil;
        self._isAnimation = false;
        self._spriteTextures = [SKTexture]();
        self._type = ActorType.None;
        super.init(coder: aDecoder);
    }
    
    func RunAnimation(){
        if(self._isAnimation)
        {
            self.runAction(self._spriteAction);
        }
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



