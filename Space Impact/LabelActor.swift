//
//  LabelActor.swift
//  Space Impact
//
//  Created by Chieh on 2/27/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class LabelActor {
    fileprivate var _labelNode:SKLabelNode;
    fileprivate var _position:CGPoint;
    fileprivate var _fontSize:CGFloat;
    fileprivate var _opacity:CGFloat;
    fileprivate var _displayText:String;
    fileprivate var _isActive:Bool;
    
    var LabelNode:SKLabelNode{get{return _labelNode}}
    var Position:CGPoint{get{return self._position} set(val){self._position = val; self._labelNode.position = val}}
    var FontSize:CGFloat{get{return self._fontSize} set(val){self._fontSize = val; self._labelNode.fontSize = val}}
    var DisplayText:String{get{return self._displayText} set(val){self._displayText = val; self._labelNode.text = val}}
    var Opacity:CGFloat{get{return self._opacity} set(val){self._opacity = val; self._labelNode.alpha = val}}
    var IsActive:Bool{get{return _isActive} set(val){self._isActive = val;}};
    
    init(displayText:String, position:CGPoint, fontSize: CGFloat, fontNamed: String?)
    {
        self._labelNode = SKLabelNode(fontNamed: fontNamed);
        self._position = position;
        self._fontSize = fontSize;
        self._displayText = displayText;
        self._opacity = 0;
        self._isActive = false;
        
        self._labelNode.position = self._position;
        self._labelNode.fontSize = self._fontSize;
        self._labelNode.text = self._displayText;
        self._labelNode.alpha = self._opacity;
    }
    
    func SetActive(_ isActive: Bool) {
        if(self.IsActive != isActive){
            UpdateStatus(isActive);
        }
        self.IsActive = isActive;
    }
    
    func UpdateStatus(_ isActive: Bool){
        if(isActive){
            GameScene.instance?.addChild(self._labelNode);
        }
        else{
            self._labelNode.removeFromParent();
        }
    }
    
    
    func FadeIn(customTime:CGFloat = GeneralGameSettings.TRANSITION_FADEIN){
        let fadeInAnimation = SKAction.fadeIn(withDuration: TimeInterval(customTime));
        if _labelNode.alpha < 1
        {
            SetActive(true);
            _labelNode.run(fadeInAnimation);
        }
    }
    
    func FadeOut(customTime:CGFloat = GeneralGameSettings.TRANSITION_FADEIN){
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(customTime));
        if _labelNode.alpha > 0
        {
            
            _labelNode.run(fadeOutAnimation, completion:{self.SetActive(false);});
        }
    }
    
    func FadeInAndOut(animationCompleted: @escaping () -> Void) {
        
        SetActive(true);
        self.LabelNode.run(self.getLevelLabelAction(), completion: {self.SetActive(false); animationCompleted();});
    }
    
    fileprivate func getLevelLabelAction() -> SKAction{
        
        let fadeInAnimation = SKAction.fadeAlpha(by: 0.8, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let bufferAnimation = SKAction.fadeAlpha(by: 1, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEOUT));
        let sequence = SKAction.sequence([fadeInAnimation,bufferAnimation, fadeOutAnimation]);
        
        return sequence;
    }

}
