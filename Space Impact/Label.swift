//
//  Label.swift
//  Space Impact
//
//  Created by Chieh on 2/27/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Label:LabelActor {
    
    private var _gameScene:GameScene?;
    

    
    init(gs:GameScene, displayText:String, position:CGPoint, fontSize: CGFloat, fontNamed: String?, opacity: CGFloat) {
        self._gameScene = gs;
        
        super.init(displayText:displayText, position:position, fontSize: fontSize, fontNamed: fontNamed, opacity:opacity);

        
        gs.addChild(self.LabelNode);
    }
}