//
//  ISpaceship.swift
//  Space Impact
//
//  Created by Chieh on 2/19/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

protocol ISpaceship {
    var Health:Int{get set};
    var Speed:CGFloat{get set};
    var Damage:Int{get set};
    //var Type:ActorType{get set};
    
    func Update();
    func AddMissle();
    func StopMissle();
}


