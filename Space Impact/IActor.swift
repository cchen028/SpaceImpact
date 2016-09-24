//
//  IActor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

protocol IActor {

    //var Scale:CGFloat { get set}
    var Position:CGPoint{get}
   // var Width:CGFloat{get}
   // var Height:CGFloat{get}
   // var ActualWidth:CGFloat{get}
   // var ActualHeight:CGFloat{get}
   // var Opacity:CGFloat{get}
    var IsActive:Bool{get}
    
    var Sprite:SpriteActor{get};
    
    func Update();
    
    func SetActive(_ isActive:Bool);
    func UpdateStatus(_ isActive: Bool);
    
  //  func Explode();
    
    
  //  func ==(lhs: IActor, rhs: IActor) -> Bool;
    
    
    
}
