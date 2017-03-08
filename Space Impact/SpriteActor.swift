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
    
    internal var _spriteAction: SKAction!;
    fileprivate var _spriteTextures: [SKTexture];
    fileprivate var _isAnimation:Bool;
    fileprivate var _type:ActorType;
    fileprivate var _isActive:Bool;
    
    var Width:CGFloat{get{return self.frame.width}}
    var Height:CGFloat{get{return self.frame.height}}
    var SpriteAction:SKAction{get{return self._spriteAction} set(val){self._spriteAction = val}}
    var `Type`:ActorType{get{return _type} set(newVal){_type = newVal}};
    var IsActive:Bool {get{return _isActive} set(newVal){ _isActive = newVal}};
    
    init(imageName:String,positionX:CGFloat, positionY: CGFloat)
    {
        self._isAnimation = false;
        self._spriteTextures = [SKTexture]();
        self._type = ActorType.None;
        self._isActive = false;
        
        let texture = GameScene.instance?.AssetService?.SKTextures[imageName];
        super.init(texture: texture, color: UIColor.clear, size: texture!.size());
        
        self.position = CGPoint(x:positionX,y:positionY);
        self.xScale = 1;
        self.yScale = 1;
        self.alpha = 1;
    }

    
    init(imageName:String,position:CGPoint, scale:CGFloat, opacity:CGFloat,type:ActorType)
    {
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
    
    init(atlasName:String,positionX:CGFloat, positionY: CGFloat ,zIndex:CGFloat = 7, timePerFrame:Double = 0.25, isRepeat:Bool = false)
    {
        self._isAnimation = true;
        self._spriteTextures = [SKTexture]();
        self._type = ActorType.Animation;
        self._isActive = false;
        
        let texture = GameScene.instance?.AssetService?.SKTextures[atlasName];
        
        super.init(texture: texture, color: UIColor.clear, size: texture!.size());
        
        self.position = CGPoint(x:positionX, y:positionY);
        self.xScale = 1;
        self.yScale = 1;
        self.alpha = 1;
        self.zPosition = zIndex;
        
        self._spriteTextures = (GameScene.instance?.AssetService?.SKTexturesList[atlasName])!;
        
        let anim = SKAction.animate(with: self._spriteTextures, timePerFrame: GeneralGameSettings.SPACESHIP_EXPLOSION_FRAMES);
        
        if(isRepeat)
        {
            self._spriteAction = SKAction.repeatForever(anim);
        }
        else
        {
            self._spriteAction = SKAction.repeat(anim, count: 1);
        }
        
//        if(startAnimating){
//            self.run(self._spriteAction);
//        }
    }

    
    init(atlasName:String,position:CGPoint, scale:CGFloat, opacity:CGFloat, type:ActorType , repeatCount:Int = -1, startAnimating:Bool = false)
    {
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
        
        let anim = SKAction.animate(with: self._spriteTextures, timePerFrame: GeneralGameSettings.SPACESHIP_EXPLOSION_FRAMES);
        
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
        self._isAnimation = false;
        self._spriteTextures = [SKTexture]();
        self._type = ActorType.None;
        self._isActive = true;
        super.init(coder: aDecoder);
    }
    
    func RunAnimation(animationComplete: @escaping ()->Void){
        
        if(self._isAnimation)
        {
            self.run(self._spriteAction, completion: {animationComplete();});
        }
    }
    
    func RunReverseAnimation(animationComplete: @escaping ()->Void){
        if(self._isAnimation)
        {
            self.run(self._spriteAction.reversed(), completion: {animationComplete();});
        }
    }

    
    func SetActive(_ isActive: Bool) {
        if(self.IsActive != isActive){
            UpdateStatus(isActive);
        }
        self._isActive = isActive;
    }
    
    func UpdateStatus(_ isActive: Bool){
        if(isActive){
            GameScene.instance?.addChild(self);
        }
        else{
            self.removeFromParent();
        }
    }
    
    func FadeIn(customTime:CGFloat = GeneralGameSettings.TRANSITION_FADEIN){
        let fadeInAnimation = SKAction.fadeIn(withDuration: TimeInterval(customTime));
        if self.alpha < 1
        {
            SetActive(true);
            self.run(fadeInAnimation);
        }
    }
    
    func FadeOut(customTime:CGFloat = GeneralGameSettings.TRANSITION_FADEIN){
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(customTime));
        if self.alpha > 0
        {
            self.run(fadeOutAnimation, completion:{self.SetActive(false)});
        }
    }
    
    func GetFadeIn(customTime:CGFloat = GeneralGameSettings.TRANSITION_FADEIN) -> SKAction{
        let fadeInAnimation = SKAction.fadeIn(withDuration: TimeInterval(customTime));
        return fadeInAnimation;
    }
    
    func GetFadeOut(customTime:CGFloat = GeneralGameSettings.TRANSITION_FADEIN) -> SKAction{
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(customTime));
        return fadeOutAnimation;
    }
    
    open func SyncPositionWith(actor: SpriteActor, offsetX: CGFloat = 0, offsetY: CGFloat = 0){
        self.position = CGPoint(x:actor.position.x + offsetX , y:actor.position.y + offsetY);
    }

}



