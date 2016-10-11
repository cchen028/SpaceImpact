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
    var Life:Int;
    var Bomb:Int;
    
    private override init(){
        self.Score.value = 0;
        self.Life = 3;
        self.Bomb = 3;
    }
    
    func Reset(){
        self.Score.value = 0;
        self.Life = 3;
        self.Bomb = 3;
    }
}
