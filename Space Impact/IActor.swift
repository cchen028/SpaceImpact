//
//  IActor.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

protocol IActor : class{

    var Scale:CGFloat { get set}
    var Position:CGPoint{get set}
    var Width:CGFloat{get}
    var Height:CGFloat{get}
    var ActualWidth:CGFloat{get}
    var ActualHeight:CGFloat{get}
    var Opacity:CGFloat{get}
    
    
    
    
    
    
    
}
