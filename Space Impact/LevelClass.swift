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
    
    override func Start(level:Int, animationCompleted: ((() -> Void)?)){
        let cur = self;
        self._level = level;
        ToggleAnimation();
        super.Start(level: level, animationCompleted: {
            let curlevel = level > 5 ? 5: level;
            let selectorMe = "Level"+String(curlevel);
            cur._levelCreateTimer = Timer.scheduledTimer(timeInterval: 0, target: cur, selector: NSSelectorFromString(selectorMe), userInfo: nil, repeats: false);
            animationCompleted?();
        });
    }
    
    override func Resume(){
        super.Resume();
        ToggleAnimation();
        let cur = self;
        let selectorMe = "Level"+String(self._level);
        cur._levelCreateTimer = Timer.scheduledTimer(timeInterval: 0, target: cur, selector: NSSelectorFromString(selectorMe), userInfo: nil, repeats: false);
        
    }
    
    override func Stop(){
        ToggleAnimation();
        super.Stop();
    }
    
    override func Update(_ currentTime: TimeInterval){
        super.Update(currentTime);
    }
    
    func Level1(){
        self.ToggleRollingRockA(isOn: true, num:2);
        self.ToggleBeaconB(isOn: true, num: 1);
    }
    
    func Level2(){
        self.ToggleRollingRockA(isOn: true, num:2);
        self.ToggleRollingRockB(isOn: true, num:2);
        self.ToggleBeaconB(isOn: true, num: 1);
    }
    
    func Level3(){
        self.ToggleRollingRockA(isOn: true, num:2);
        self.ToggleRollingRockB(isOn: true, num:2);
        self.ToggleEnemySpaceshipA(isOn: true, num:1);
        self.ToggleBeaconB(isOn: true, num: 1);
    }
    
    func Level4(){
        self.ToggleRollingRockA(isOn: true, num:1);
        self.ToggleRollingRockB(isOn: true, num:1);
        self.ToggleEnemySpaceshipA(isOn: true, num:1);
        self.ToggleEnemySpaceshipB(isOn: true, num:2);
        self.ToggleBeaconB(isOn: true, num: 1);
    }
    
    func Level5(){
        self.ToggleBoss(playerSpaceship: self._playerSpaceship);
    }
    
    fileprivate func ToggleAnimation(){
        for obj in self.Enemies{
            obj.Spaceship.isPaused = GameObjectServices.instance.IsPaused;
        }
        
        for obj in self.Items{
            obj.Item.isPaused = GameObjectServices.instance.IsPaused;
        }
    }
}
