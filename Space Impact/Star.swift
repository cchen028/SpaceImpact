//
//  Star.swift
//  Space Impact
//
//  Created by Chieh on 2/23/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

public class Star: ShapeActor {
    private var _speed:CGFloat;
    private var _type:StarType;
    
    var Speed:CGFloat{get{return self._speed}};
    var Type:StarType{get{return _type} set(newVal){_type = newVal}};
    
    init(type:StarType, position:CGPoint)
    {
        switch(type)
        {
        case .Fast:
            self._speed = 2;
        case .Medium:
            self._speed = 1;
        case .Slow:
            self._speed = 0.5;
        default:
            self._speed = 1;
        }
        
        self._type = type;
        
        super.init(type: ShapeActorType.Circle, width: 1, height: 1, position: position,opacity:0.7, glowWidth: 0, strokeColor: SKColor.whiteColor(), fillColor: SKColor.whiteColor());
        
    }
    
    public func Update(){
        if super.Position.y < 0{
            let randomX = Int(arc4random_uniform(400) + 1);
            super.Position = CGPoint(x:randomX, y:800);
        }
        else{
            super.Position.y -= self._speed;
        }
    }
    
    
}


enum StarType:Int{
    case Fast = 1,Medium,Slow
}