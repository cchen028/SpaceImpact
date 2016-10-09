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
    
    fileprivate var _spriteAction: SKAction!;
    fileprivate var _spriteTextures: [SKTexture];
    fileprivate var _isAnimation:Bool;
   // fileprivate var _gameScene:GameScene?;
    fileprivate var _type:ActorType;
    fileprivate var _isActive:Bool;
    
    var Width:CGFloat{get{return self.frame.width}}
    var Height:CGFloat{get{return self.frame.height}}
    var SpriteAction:SKAction{get{return self._spriteAction} set(val){self._spriteAction = val}}
    var `Type`:ActorType{get{return _type} set(newVal){_type = newVal}};
    var IsActive:Bool {get{return _isActive} set(newVal){ _isActive = newVal}};
    
    init(imageName:String,position:CGPoint, scale:CGFloat, opacity:CGFloat,type:ActorType)
    {
       // self._gameScene = gs;
        self._isAnimation = false;
        self._spriteTextures = [SKTexture]();
        self._type = type;
        self._isActive = false;
        
        let texture = GameScene.instance?.AssetService?.SKTextures[imageName];
        super.init(texture: texture, color: UIColor.clear, size: texture!.size());
        
        self.position = position;
        self.xScale = scale;
        self.yScale = scale;
        self.alpha = opacity;
       

    }
    
    init(atlasName:String,position:CGPoint, scale:CGFloat, opacity:CGFloat, frameCount:Int, type:ActorType , repeatCount:Int = -1, startAnimating:Bool = false)
    {
      //  self._gameScene = gs;
        self._isAnimation = true;
        self._spriteTextures = [SKTexture]();
        self._type = type;
        self._isActive = false;
        
        let texture = GameScene.instance?.AssetService?.SKTextures[atlasName];
        
        super.init(texture: texture, color: UIColor.clear, size: texture!.size());
        
        self.position = position;
        self.xScale = scale;
        self.yScale = scale;
        self.alpha = opacity;
        
        self._spriteTextures = (GameScene.instance?.AssetService?.SKTexturesList[atlasName])!;
        
        let anim = SKAction.animate(with: self._spriteTextures, timePerFrame: 0.025);
        
        if(repeatCount == -1)
        {
            self._spriteAction = SKAction.repeatForever(anim);
        }
        else
        {
            self._spriteAction = SKAction.repeat(anim, count: repeatCount);
        }
        
        if(startAnimating){
            self.run(self._spriteAction);
        }
    }

    required init?(coder aDecoder: NSCoder) {
        //self._gameScene = nil;
        self._isAnimation = false;
        self._spriteTextures = [SKTexture]();
        self._type = ActorType.None;
        self._isActive = true;
        super.init(coder: aDecoder);
    }
    
    func RunAnimation(){
        if(self._isAnimation)
        {
            self.alpha = 1;
            self.run(self._spriteAction, completion: {self.UpdateStatus(false)});
        }
    }
    
    func SetActive(_ isActive: Bool) {
        if(self.IsActive != isActive){
            UpdateStatus(isActive);
        }
        self._isActive = isActive;
        
        
//        if(self._isActive == isActive)
//        {
//            return;
//        }
//        else{
//            self._isActive = isActive;
//        }
//        
//        if(isActive){
//            Active();
//        }
//        else
//        {
//            InActive();
//        }
    }
    
    func UpdateStatus(_ isActive: Bool){
        if(isActive){
            self.alpha = 1;
            GameObjectServices.instance.GameScreen?.addChild(self);
        }
        else{
            
            self.alpha = 0;
           // self.removeFromParent();
            self.removeAllActions();
            self.removeAllChildren();
            self.removeFromParent();
        }
    }
    
    func Explode(){
        self.alpha = 1;
        self.run(self._spriteAction, completion: {self.UpdateStatus(false)});
    }

    
//    func Active(){
//        GameScene.instance!.childNodeWithNodeType(NodeType.GameScreen)?.addChild(self);
//    }
//    
//    func InActive(){
//        self.removeFromParent();
//    }
    
    fileprivate func getFileName(_ name:String, orderNumber:Int) -> String{
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



