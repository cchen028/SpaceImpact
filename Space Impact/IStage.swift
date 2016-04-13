//
//  Stage.swift
//  Space Impact
//
//  Created by Chieh on 2/23/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

protocol IStage {
    var Name:String{get};
    var IsActive:Bool{get};
    
    func Notify(targetStage:String)
    func SetActive(isActive:Bool);
    func Active();
    func InActive();
}

