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
    
    init(){
        super.init(displayText: "", position: CGPoint(x:0,y:0), fontSize: 25, fontNamed: nil)
    }
    
    override init(displayText:String, position:CGPoint, fontSize: CGFloat, fontNamed: String?) {
        
        super.init(displayText:displayText, position:position, fontSize: fontSize, fontNamed: fontNamed);
        self.LabelNode.zPosition = 10;
    }
    
    override func SetActive(_ isActive: Bool) {
        super.SetActive(isActive);
    }

}


