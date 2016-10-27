//
//  Level1.swift
//  Space Impact
//
//  Created by Chieh on 10/24/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class LevelClass: LevelActor {

    override init(){
        super.init();
    }
    
    
    override func Start(level:Int, animationCompleted: ((() -> Void)?)){
        let cur = self;
        self._level = level;
        super.Start(level: level, animationCompleted: {
            let curlevel = level > 4 ? 4: level;
            let selectorMe = "Level"+String(curlevel);
            cur._levelCreateTimer = Timer.scheduledTimer(timeInterval: 0, target: cur, selector: NSSelectorFromString(selectorMe), userInfo: nil, repeats: false);
        });
    }
    
    
    override func Update(){
        super.Update();
    }
    
    
    
    func Level1(){
        self.ToggleEnemySpaceshipB(isOn: true, num:3);
       // self.ToggleRollingRockA(isOn: true, num:3);
       // self.ToggleRollingRockB(isOn: true, num:3);
    }
    
    func Level2(){
        self.ToggleRollingRockA(isOn: true, num:3);
       // self.ToggleRollingRockB(isOn: true, num:3);
      //  self.ToggleEnemySpaceshipA(isOn: true, num:3);
    }
    
    func Level3(){
//        self.ToggleRollingRockA(isOn: true, num:3);
//        self.ToggleRollingRockB(isOn: true, num:3);
//        self.ToggleEnemySpaceshipA(isOn: true, num:1);
        self.ToggleEnemySpaceshipB(isOn: true, num:3);
    }
    
    func Level4(){
//        self.ToggleRollingRockA(isOn: true, num:1);
//        self.ToggleRollingRockB(isOn: true, num:1);
//        self.ToggleEnemySpaceshipA(isOn: true, num:1);
        self.ToggleEnemySpaceshipB(isOn: true, num:3);
    }


}
