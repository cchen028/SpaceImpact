//
//  ITouchable.swift
//  Space Impact
//
//  Created by Chieh on 2/17/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

protocol ITouchable {
    //func HandlesTouch(touches: Set<UITouch>, withEvent event: UIEvent?)
    func IsTouched(touch: UITouch, withEvent event: UIEvent?)->Bool
}


//class Touchable:ITouchable{
    
    
//}