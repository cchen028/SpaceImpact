//
//  Star.swift
//  Space Impact
//
//  Created by Chieh on 2/23/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

open class Star: ShapeActor {
    fileprivate var _speed:CGFloat;
    fileprivate var _type:StarType;
    fileprivate var _glow:CGFloat;
    
    var Speed:CGFloat{get{return self._speed}};
    var `Type`:StarType{get{return _type} set(newVal){_type = newVal}};
    
    init(type:StarType, position:CGPoint)
    {
        switch(type)
        {
        case .fast:
            self._speed = 2;
            self._glow = 1;
        case .medium:
            self._speed = 1;
            self._glow = 0.2;
        case .slow:
            self._speed = 0.5;
            self._glow = 0;
        }
        
        self._type = type;
        
        super.init(type: ShapeActorType.circle, width: 1, height: 1, position: position,opacity:0.7, glowWidth: self._glow, strokeColor: SKColor.white, fillColor: SKColor.white);
        
    }

    required public init?(coder aDecoder: NSCoder) {
        self._speed = 0;
        self._glow = 0;
        self._type = StarType.slow;
        super.init(coder: aDecoder);
    }
    
    open func Update(){
        if super.position.y < 0{
            super.position = SpriteServices.GenerateRandomPosition();
        }
        else{
            super.position.y -= self._speed;
        }
    }
    
    open func MainMenuSpecialEffect(){
            if (super.position.y < 600 && super.position.y > 500) || (super.position.y < 450 && super.position.y > 300 && super.position.x > 100 && super.position.x < 300){
                if(super.alpha>0.2)
                {
                    super.alpha -= 0.01;
                }
            }
            else
            {
                if(super.alpha<0.7)
                {
                    super.alpha += 0.01;
                }
            }
    }
    
    open func DefaultSpecialEffect(){
        super.alpha = 0.7;
    }
}


enum StarType:Int{
    case fast = 1,medium,slow
}
