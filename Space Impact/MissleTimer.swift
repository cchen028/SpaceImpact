//
//  MissleTimer.swift
//  Space Impact
//
//  Created by Chieh on 3/9/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class MissleTimer: NSObject {
    fileprivate var _spaceshipMissleTimer: Timer?;
    
    override init(){
        super.init();
    }
    
//    func StartMissle(_ target:ISpaceship, missleFz:Double)
//    {
//        _spaceshipMissleTimer = Timer.scheduledTimer(timeInterval: missleFz, target: target, selector: "AddMissle", userInfo: nil, repeats: true);
//    }
//    
//    func StopMissle()
//    {
//        _spaceshipMissleTimer!.invalidate();
//        _spaceshipMissleTimer = nil;
//    }
    
    func ToggleMissleTimer(isOn:Bool, targetSpaceship:ISpaceship, missleFz: Double){
        if(isOn){
            _spaceshipMissleTimer = Timer.scheduledTimer(timeInterval: missleFz, target: targetSpaceship, selector: "AddMissle", userInfo: nil, repeats: true);
        }
        else{
            targetSpaceship.StopMissle();
            _spaceshipMissleTimer?.invalidate();
        }
    }

}
