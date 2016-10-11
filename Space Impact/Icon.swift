//
//  Icon.swift
//  Space Impact
//
//  Created by Chieh on 10/9/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Icon:SpriteActor {
    
    init(imageName:String,position:CGPoint)
    {
        super.init(imageName: imageName, position: position, scale: 1, opacity: 0, type:ActorType.Icon);
        GameScene.instance!.addChild(self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }


}


