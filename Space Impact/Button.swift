//
//  Button.swift
//  Space Impact
//
//  Created by Chieh on 2/25/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Button: SpriteActor,ITouchable{
    
    fileprivate var _displayText:String;
    fileprivate var _labelNode:Label?;
    
    var DisplayText:String{get{return self._displayText}}
    var LabelNode:Label{get{return self._labelNode!}}
    
    init(displayText: String, position: CGPoint, fontName:String?, fontSize:CGFloat, imageName:String){
        self._displayText = displayText;
        self._labelNode = Label(displayText:displayText, position:position, fontSize: fontSize, fontNamed: fontName);
        
        super.init(imageName: imageName, position: CGPoint(x:position.x,y:position.y), scale: 1, opacity: 0, type:ActorType.Button)
        self.name = displayText.replacingOccurrences(of: " ", with: "_");
        
        //adjusting position
        self.position = CGPoint(x:_labelNode!.Position.x, y:_labelNode!.Position.y - ( (self.Height-_labelNode!.LabelNode.frame.height)/4));
        self.zPosition = 10;
    }

    required init?(coder aDecoder: NSCoder) {
        self._displayText = "";
        self._labelNode = nil;
        super.init(coder: aDecoder);
    }
    
    func IsTouched(_ touch: UITouch, withEvent event: UIEvent?)->Bool
    {
        let location = touch.location(in: GameScene.instance!);
        let node = GameScene.instance!.atPoint(location) as SKNode;
        
        if(node.position==self.position)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    override func SetActive(_ isActive: Bool) {
        self._labelNode?.SetActive(isActive);
        super.SetActive(isActive);
    }
    
    override func FadeIn(customTime:CGFloat? = GeneralGameSettings.TRANSITION_FADEIN, animationCompleted: (() -> Void)? = nil){
        self._labelNode?.FadeIn(customTime:customTime!);
        super.FadeIn(customTime: customTime!, animationCompleted:animationCompleted);
    }
    
    override func FadeOut(customTime:CGFloat? = GeneralGameSettings.TRANSITION_FADEIN, animationCompleted: (() -> Void)? = nil){
        self._labelNode?.FadeOut(customTime:customTime!);
        super.FadeOut(customTime: customTime!, animationCompleted:animationCompleted);
    }
}
