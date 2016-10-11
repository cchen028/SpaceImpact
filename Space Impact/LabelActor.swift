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
    
    
    var LabelNode:SKLabelNode{get{return _labelNode}}
    
    
    var Position:CGPoint{get{return self._position} set(val){self._position = val; self._labelNode.position = val}}
    var FontSize:CGFloat{get{return self._fontSize} set(val){self._fontSize = val; self._labelNode.fontSize = val}}
    var DisplayText:String{get{return self._displayText} set(val){self._displayText = val; self._labelNode.text = val}}
    var Opacity:CGFloat{get{return self._opacity} set(val){self._opacity = val; self._labelNode.alpha = val}}
    
    init(displayText:String, position:CGPoint, fontSize: CGFloat, fontNamed: String?, opacity: CGFloat)
    {
        self._labelNode = SKLabelNode(fontNamed: fontNamed);
        self._position = position;
        self._fontSize = fontSize;
        self._displayText = displayText;
        self._opacity = opacity;
        
        self._labelNode.position = self._position;
        self._labelNode.fontSize = self._fontSize;
        self._labelNode.text = self._displayText;
        self._labelNode.alpha = self._opacity;
    }
    
//    func Update(text:String){
//        self._labelNode.observeValue(forKeyPath: String?, of: <#T##Any?#>, change: <#T##[NSKeyValueChangeKey : Any]?#>, context: <#T##UnsafeMutableRawPointer?#>)
//    }
    
    func FadeIn(){
        let fadeInAnimation = SKAction.fadeIn(withDuration: TimeInterval(GeneralGameSettings.TRANSITION_FADEIN));
        if _labelNode.alpha < 1
        {
            _labelNode.run(fadeInAnimation);
        }
    }
    
    func FadeOut(){
        let fadeOutAnimation = SKAction.fadeIn(withDuration: TimeInterval(GeneralGameSettings.TRANSITION_FADEOUT));
        if _labelNode.alpha > 0
        {
            _labelNode.run(fadeOutAnimation);
        }
    }
    
//    func FadeInAndOut() -> SKAction{
//        _labelNode.alpha = 0;
//        let fadeInAnimation = SKAction.fadeAlpha(by: 0.8, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
//        let bufferAnimation = SKAction.fadeAlpha(by: 1, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
//        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEOUT));
//
//        let sequence = SKAction.sequence([fadeInAnimation,bufferAnimation, fadeOutAnimation]);
//        
//        
//        return sequence;
//        //_labelNode.run(sequence)
//        
//    }

    
}
