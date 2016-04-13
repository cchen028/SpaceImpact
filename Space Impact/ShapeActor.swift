//
//  Actor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

public class ShapeActor: SKShapeNode {
    
    init(type:ShapeActorType, width:CGFloat, height:CGFloat, position:CGPoint,opacity:CGFloat,glowWidth:CGFloat, strokeColor:SKColor, fillColor:SKColor)
    {
        switch(type)
        {
        case ShapeActorType.Circle:
            super.init();
            let diameter = width * 2;
            self.path = CGPathCreateWithEllipseInRect(CGRect(origin: CGPointZero, size:CGSize(width:diameter, height: diameter)), nil);
            self.position = position;
        case ShapeActorType.Rectangle:
            super.init(rect: CGRect(x:-50,y:-20,width: width,height:height));
        default:
            super.init();
        }
        
        self.position = position;
        self.strokeColor = strokeColor;
        self.fillColor = fillColor;
        self.glowWidth = glowWidth;
        self.alpha = opacity
        
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}

enum ShapeActorType:Int{
    case Circle = 1, Rectangle
    
}

