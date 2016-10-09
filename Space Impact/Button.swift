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
    fileprivate var _alpha:CGFloat;
    
    var DisplayText:String{get{return self._displayText}}
    var Alpha:CGFloat{get{return self._alpha}}
    var LabelNode:Label{get{return self._labelNode!}}
    
    init(displayText: String, position: CGPoint, opacity: CGFloat, fontName:String?, fontSize:CGFloat, imageName:String){
        self._displayText = displayText;
        self._alpha = opacity;
        self._labelNode = Label(displayText:displayText, position:position, fontSize: fontSize, fontNamed: fontName, opacity: self._alpha);
        
        super.init(imageName: imageName, position: CGPoint(x:position.x,y:position.y), scale: 1, opacity: opacity, type:ActorType.Button)
        self.name = displayText.replacingOccurrences(of: " ", with: "_");
        
        //adjusting position
        self.position = CGPoint(x:_labelNode!.Position.x, y:_labelNode!.Position.y - ( (self.Height-_labelNode!.LabelNode.frame.height)/4));
        GameScene.instance!.addChild(self);
    }

    required init?(coder aDecoder: NSCoder) {
        self._displayText = "";
        self._alpha = 1;
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
    
    override func FadeIn(){
        self._labelNode?.FadeIn();
        super.FadeIn()
    }

    
}
