//
//  MissleTimer.swift
//  Space Impact
//
//  Created by Chieh on 3/9/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class MissleTimer: NSObject {
    private var _spaceshipMissleTimer: NSTimer?;
    
    override init(){
        super.init();
    }
    
    func StartMissle(target:ISpaceship)
    {
        if let node = target as? SpaceshipActor{
            
            _spaceshipMissleTimer = NSTimer.scheduledTimerWithTimeInterval(GeneralGameSettings.MyMissle_Frequency, target: node, selector: "AddMissle", userInfo: nil, repeats: true);
        }
    }
    
    func StopMissle()
    {
        _spaceshipMissleTimer?.invalidate();
    }

}
