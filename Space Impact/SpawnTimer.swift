//
//  SpawnTimer.swift
//  Space Impact
//
//  Created by Chieh on 10/27/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class SpawnTimer{
    
    fileprivate var initialInterval = TimeInterval(0);
    
    // Time of last update(currentTime:) call
    var lastUpdateTime = TimeInterval(0)
    
    // Seconds elapsed since last action
    var timeSinceLastAction = TimeInterval(0)
    
    // Seconds before performing next action. Choose a default value
    var timeUntilNextAction = TimeInterval(4)
    
    init(interval:Double){
        initialInterval = interval;
        Reset();
    }
    
    func Reset(){
        lastUpdateTime = TimeInterval(0);
        timeSinceLastAction = TimeInterval(0);
        timeUntilNextAction = TimeInterval(initialInterval);
    }
    
    func IsTimeToSpawn(_ currentTime: TimeInterval) -> Bool {
        
        let delta = currentTime - lastUpdateTime;
        lastUpdateTime = currentTime;
        
        timeSinceLastAction += delta
        
        if timeSinceLastAction >= timeUntilNextAction {
            
            // perform your action
            
            // reset
            timeSinceLastAction = TimeInterval(0)
            // Randomize seconds until next action
            timeUntilNextAction = CDouble(arc4random_uniform(6))
            
            return true;
            
        }
        
        return false;
        
    }
    

    
    
}
