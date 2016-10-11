//
//  Actor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

open class ShapeActor: SKShapeNode {
    
    init(type:ShapeActorType, width:CGFloat, height:CGFloat, position:CGPoint,opacity:CGFloat,glowWidth:CGFloat, strokeColor:SKColor, fillColor:SKColor)
    {
        switch(type)
        {
        case ShapeActorType.circle:
            super.init();
            let diameter = width * 2;
            self.path = CGPath(ellipseIn: CGRect(origin: CGPoint.zero, size:CGSize(width:diameter, height: diameter)), transform: nil);
            self.position = position;
        case ShapeActorType.rectangle:
            super.init(rect: CGRect(x:-50,y:-20,width: width,height:height));
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
    case circle = 1, rectangle
    
}

