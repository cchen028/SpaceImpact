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
    private var _glow:CGFloat;
    
    var Speed:CGFloat{get{return self._speed}};
    var Type:StarType{get{return _type} set(newVal){_type = newVal}};
    
    init(type:StarType, position:CGPoint)
    {
        switch(type)
        {
        case .Fast:
            self._speed = 2;
            self._glow = 1;
            break
        case .Medium:
            self._speed = 1;
            self._glow = 0.2;
            break
        case .Slow:
            self._speed = 0.5;
            self._glow = 0;
            break
        default:
            self._speed = 0;
            self._glow = 0;
            break
        }
        
        self._type = type;
        
        super.init(type: ShapeActorType.Circle, width: 1, height: 1, position: position,opacity:0.7, glowWidth: self._glow, strokeColor: SKColor.whiteColor(), fillColor: SKColor.whiteColor());
        
    }

    required public init?(coder aDecoder: NSCoder) {
        self._speed = 0;
        self._glow = 0;
        self._type = StarType.Slow;
        super.init(coder: aDecoder);
    }
    
    public func Update(){
        if super.position.y < 0{
            super.position = SpriteServices.GenerateRandomPosition();
        }
        else{
            super.position.y -= self._speed;
        }
        
        
    }
    
    public func MainMenuSpecialEffect(){
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
    
    public func DefaultSpecialEffect(){
        super.alpha = 0.7;
    }
}


enum StarType:Int{
    case Fast = 1,Medium,Slow
}