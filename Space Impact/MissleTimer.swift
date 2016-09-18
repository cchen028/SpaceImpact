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
    
    func StartMissle(_ target:ISpaceship)
    {
        if let node = target as? SpaceshipActor{
            
            _spaceshipMissleTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.MyMissle_Frequency, target: node, selector: Selector("AddMissle"), userInfo: nil, repeats: true);
        }
    }
    
    func StopMissle()
    {
        _spaceshipMissleTimer?.invalidate();
    }

}
