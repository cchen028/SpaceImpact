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
        case .Medium:
            self._speed = 1;
            self._glow = 0.2;
        case .Slow:
            self._speed = 0.5;
            self._glow = 0;
        default:
            self._speed = 0;
            self._glow = 0;
        }
        
        self._type = type;
        
        super.init(type: ShapeActorType.Circle, width: 1, height: 1, position: position,opacity:0.7, glowWidth: self._glow, strokeColor: SKColor.whiteColor(), fillColor: SKColor.whiteColor());
        
    }
    
    public func Update(){
        if super.Position.y < 0{
            let randomX = Int(arc4random_uniform(UInt32(GeneralGameSettings.SCREEN_WIDTH)) + 1);
            super.Position = CGPoint(x:randomX, y:GeneralGameSettings.SCREEN_HEIGHT);
        }
        else{
            super.Position.y -= self._speed;
        }
        
        
    }
    
    public func MainMenuSpecialEffect(){
            if (super.Position.y < 600 && super.Position.y > 500) || (super.Position.y < 450 && super.Position.y > 300 && super.Position.x > 100 && super.Position.x < 300){
                if(super.Opacity>0.2)
                {
                    super.Opacity -= 0.01;
                }
            }
            else
            {
                if(super.Opacity<0.7)
                {
                    super.Opacity += 0.01;
                }
            }
    }
    
    public func DefaultSpecialEffect(){
        super.Opacity = 0.7;
    }
    
    
}


enum StarType:Int{
    case Fast = 1,Medium,Slow
}