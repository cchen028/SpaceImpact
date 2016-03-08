//
//  LabelActor.swift
//  Space Impact
//
//  Created by Chieh on 2/27/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class LabelActor {
    private var _labelNode:SKLabelNode;
   // private var _scale:CGFloat;
    private var _position:CGPoint;
    private var _fontSize:CGFloat;
   // private var _width:CGFloat;
   // private var _height:CGFloat;
   // private var _strokeColor:SKColor;
   // private var _fillColor:SKColor;
   // private var _glowWidth:CGFloat;
    private var _opacity:CGFloat;
    private var _displayText:String;
    
    
    var LabelNode:SKLabelNode{get{return _labelNode}}
    
    
    var Position:CGPoint{get{return self._position} set(val){self._position = val; self._labelNode.position = val}}
    var FontSize:CGFloat{get{return self._fontSize} set(val){self._fontSize = val; self._labelNode.fontSize = val}}
    var DisplayText:String{get{return self._displayText} set(val){self._displayText = val; self._labelNode.text = val}}
 //   var Width:CGFloat{get{return self._width}}
   // var Height:CGFloat{get{return self._height}}
    var Opacity:CGFloat{get{return self._opacity} set(val){self._opacity = val; self._labelNode.alpha = val}}
    
   // var ActualWidth:CGFloat{get{return self._width}}
  //  var ActualHeight:CGFloat{get{return self._height}}
  //  var Scale:CGFloat { get{return self._scale} set{self._scale = 1}}
   // var StrokeColor:SKColor{get{return self._strokeColor} set(val){self._strokeColor = val; self._shape.strokeColor = val}}
   // var FillColor:SKColor{get{return self._fillColor} set(val){self._fillColor = val; self._shape.fillColor = val}}
   // var GlowWidth:CGFloat{get{return self._glowWidth} set(val){self._glowWidth = val; self._shape.glowWidth = val}}
    
    init(displayText:String, position:CGPoint, fontSize: CGFloat, fontNamed: String?, opacity: CGFloat)
    {
        self._labelNode = SKLabelNode(fontNamed: fontNamed);
        self._position = position;
        self._fontSize = fontSize;
        self._displayText = displayText;
        self._opacity = opacity;
        
        self._labelNode.position = self._position;
        self._labelNode.fontSize = self._fontSize;
        self._labelNode.text = self._displayText;
        self._labelNode.alpha = self._opacity;
     //   self._width = self._shape.frame.size.width;
    //    self._height = self._shape.frame.size.height;
    //    self._scale = 1;
     //   self._strokeColor = strokeColor;
     //   self._fillColor = fillColor;
     //   self._glowWidth = glowWidth;
     //   self._opacity = opacity;
        
        
     //   self._shape.position = self._position;
     //   self._shape.strokeColor = self._strokeColor;
     //   self._shape.fillColor = self._fillColor;
     //   self._shape.glowWidth = self._glowWidth;
     //   self._shape.alpha = self._opacity
        
    }
    
    

}
