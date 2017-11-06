//
//  UserStatsInfo.swift
//  Space Impact
//
//  Created by Chieh on 10/9/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
import SpriteKit

class UserStatsInfo: NSObject {
    
    static let instance = UserStatsInfo();
    
    var Score = DynamicInt(0);
    var Life = DynamicInt(3);
    var Bomb = DynamicInt(3);
    var Gem = DynamicInt(0);
    
    private override init(){
        self.Score.value = 0;
        self.Life.value = 3;
        self.Bomb.value = 3;
        self.Gem.value = 0; // get from server
    }
    
    func Reset(){
        self.Score.value = 0;
        self.Life.value = 3;
        self.Bomb.value = 3;
    }
}
