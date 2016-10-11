//
//  Actor.swift
//  Space Impact
//
//  Created by Chieh on 3/7/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

open class Actor {

    var _scale:CGFloat;
    var _position:CGPoint;
    var _width:CGFloat;
    var _height:CGFloat;
    var _opacity:CGFloat;

    var Scale:CGFloat{get{return self._scale} set(val){self._scale = val;}}
    var Position:CGPoint{get{return self._position} set(val){self._position = val}}
    var Width:CGFloat{get{return self._width}}
    var Height:CGFloat{get{return self._height}}
    var ActualWidth:CGFloat{get{return self._width * self._scale}}
    var ActualHeight:CGFloat{get{return (self._height) * self._scale}}
    var Opacity:CGFloat{get{return self._opacity} set(val){self._opacity = val;}}

    init(position:CGPoint, scale:CGFloat, width:CGFloat, height:CGFloat, opacity:CGFloat)
    {
        self._position = position;
        self._scale = scale;
        self._width = width;
        self._height = height;
        self._opacity = opacity;
    }
}
