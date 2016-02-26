//
//  Button.swift
//  Space Impact
//
//  Created by Chieh on 2/25/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Button: ShapeActor {
    
    private var _displayText:String;
    private var _gameScene:GameScene;
    private var _labelNode:SKLabelNode;
    
    var DisplayText:String{get{return self._displayText}}
    var Label:SKLabelNode{get{return self._labelNode}}
    
    init(gs:GameScene, displayText: String, position: CGPoint){
        self._displayText = displayText;
        self._gameScene = gs;
        self._labelNode = SKLabelNode(fontNamed:"Chalkduster");
        self._labelNode.text = self._displayText;
        self._labelNode.fontSize = 20;
        self._labelNode.position = position;
        
        super.init(type: ShapeActorType.Rectangle, width: 100.0, height: 40, position: position, opacity: 1, glowWidth: 1, strokeColor: SKColor.blueColor(), fillColor: SKColor(white:1, alpha: 0.1));
        
        
        gs.addChild(self._labelNode);
        gs.addChild(self.Shape);
    }
    
}
