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
    fileprivate var _playerSpaceship:Spaceship;
    
    init(userSpaceship:Spaceship){
        self._playerSpaceship = userSpaceship;
        super.init();
    }
    
//    override init(){
//        super.init();
//    }
    
    
    
    override func Start(level:Int, animationCompleted: ((() -> Void)?)){
        let cur = self;
        self._level = level;
        self._isActive = false;
        super.Start(level: level, animationCompleted: {
            let curlevel = level > 5 ? 5: level;
            let selectorMe = "Level"+String(curlevel);
            self._isActive = true;
            cur._levelCreateTimer = Timer.scheduledTimer(timeInterval: 0, target: cur, selector: NSSelectorFromString(selectorMe), userInfo: nil, repeats: false);
        });
    }
    
    override func Update(_ currentTime: TimeInterval){
        if(self._isActive)
        {
            super.Update(currentTime);
        }
    }
    
    func Level1(){
        self.ToggleRollingRockA(isOn: true, num:2);
        self.ToggleBeaconB(isOn: true, num: 1);
    }
    
    func Level2(){
        self.ToggleRollingRockA(isOn: true, num:2);
        self.ToggleRollingRockB(isOn: true, num:2);
    }
    
    func Level3(){
        self.ToggleRollingRockA(isOn: true, num:2);
        self.ToggleRollingRockB(isOn: true, num:2);
        self.ToggleEnemySpaceshipA(isOn: true, num:1);
    }
    
    func Level4(){
        self.ToggleRollingRockA(isOn: true, num:1);
        self.ToggleRollingRockB(isOn: true, num:1);
        self.ToggleEnemySpaceshipA(isOn: true, num:1);
        self.ToggleEnemySpaceshipB(isOn: true, num:2);
    }
    
    func Level5(){
        self.ToggleBoss(playerSpaceship: self._playerSpaceship);
    }
}
