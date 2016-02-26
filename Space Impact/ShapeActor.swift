//
//  Actor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

public class ShapeActor: IActor {
    
    private var _shape:SKShapeNode;
    private var _scale:CGFloat;
    private var _position:CGPoint;
    private var _width:CGFloat;
    private var _height:CGFloat;
    private var _strokeColor:SKColor;
    private var _fillColor:SKColor;
    private var _glowWidth:CGFloat;
    private var _opacity:CGFloat;
    
    
    var Shape:SKShapeNode{get{return _shape}}
    

    var Position:CGPoint{get{return self._position} set(val){self._position = val; self._shape.position = val}}
    var Width:CGFloat{get{return self._width}}
    var Height:CGFloat{get{return self._height}}
    var Opacity:CGFloat{get{return self._opacity}}
    
    var ActualWidth:CGFloat{get{return self._width}}
    var ActualHeight:CGFloat{get{return self._height}}
    var Scale:CGFloat { get{return self._scale} set{self._scale = 1}}
    var StrokeColor:SKColor{get{return self._strokeColor} set(val){self._strokeColor = val; self._shape.strokeColor = val}}
    var FillColor:SKColor{get{return self._fillColor} set(val){self._fillColor = val; self._shape.fillColor = val}}
    var GlowWidth:CGFloat{get{return self._glowWidth} set(val){self._glowWidth = val; self._shape.glowWidth = val}}
    
    init(type:ShapeActorType, width:CGFloat, height:CGFloat, position:CGPoint,opacity:CGFloat,glowWidth:CGFloat, strokeColor:SKColor, fillColor:SKColor)
    {
        
        switch(type)
        {
        case ShapeActorType.Circle:
            self._shape = SKShapeNode(circleOfRadius: CGFloat(width));
            self._position = position;
        case ShapeActorType.Rectangle:
            self._shape = SKShapeNode(rect: CGRect(x:-50,y:-20,width: width,height:height));
            self._shape.lineWidth = 2;
            self._position = position;
        default:
            let location = CGPoint(x:300, y:50);
            self._shape = SKShapeNode(circleOfRadius: CGFloat(width));
            self._position = location;
        }
        
        self._width = self._shape.frame.size.width;
        self._height = self._shape.frame.size.height;
        self._scale = 1;
        self._strokeColor = strokeColor;
        self._fillColor = fillColor;
        self._glowWidth = glowWidth;
        self._opacity = opacity;
        
        
        self._shape.position = self._position;
        self._shape.strokeColor = self._strokeColor;
        self._shape.fillColor = self._fillColor;
        self._shape.glowWidth = self._glowWidth;
        self._shape.alpha = self._opacity
        
    }
    
    convenience init(type:ShapeActorType, width:CGFloat){
        self.init(type:type,width:width,height:width,position:CGPoint(x:300,y:900),opacity:1, glowWidth: 0, strokeColor:SKColor.whiteColor(), fillColor: SKColor.whiteColor());
    }
    
    
}

enum ShapeActorType:Int{
    case Circle = 1, Rectangle
    
}

