//
//  Item.swift
//  Space Impact
//
//  Created by Chieh on 10/22/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Item: ItemActor{
    
    fileprivate var _initialPosition:CGPoint;
    //var Sprite:SpriteActor { get{return self.Item}}
    
    init(atlasItemName:String,exposionName:String, position:CGPoint, itemType: ActorType)
    {
        self._initialPosition = position;
        super.init(atlasItemName: atlasItemName,exposionName:exposionName, itemType: itemType, position: position, speed: 1.5);
        
    }
    
    override func Update(){
        super.Update();
    }
    
    
}
