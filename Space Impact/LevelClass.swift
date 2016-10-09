//
//  Level1.swift
//  Space Impact
//
//  Created by Chieh on 9/21/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation

class LevelClass: NSObject {
    
    fileprivate var _enemies:[IActor];
    fileprivate var _isActive: Bool;
    fileprivate var _level:Int;
    fileprivate var _rollingRockASpawnTimer: Timer?;
    
    var Enemies:[IActor]{get{return self._enemies}}
    var IsActive:Bool{get{return self._isActive}}
    
    override init(){
        self._enemies = [IActor]();
        self._isActive = false;
        self._level = 0;
        super.init();
        self.initializeRollingRockA(num:5);
    }
    
    func StartLevel(level:Int){
        self._level = level;
        self.EnemySpawnTimer(isOn: true);
    }
    
    func Destroy(){
        self._level = 0;
        self.EnemySpawnTimer(isOn: false);
        self._enemies = [IActor]();
    }
    
    func EnemySpawnTimer(isOn:Bool){
        if(isOn){
            _rollingRockASpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKA_SPAWN, target: self, selector: "SpawnRollingRockA", userInfo: nil, repeats: true);
        }
        else{
            _rollingRockASpawnTimer!.invalidate();
            _rollingRockASpawnTimer = nil;
        }
    }
    
    func Update(){
        for obj in self._enemies{
            if let rollingRockA = obj as? RollingRockA {
                rollingRockA.Update();
            }
        }
    }
    
    func SpawnRollingRockA(){
        for obj in self._enemies{
            if var rollingRockA = obj as? RollingRockA , !rollingRockA.IsActive {
                rollingRockA.Position = SpriteServices.GenerateRandomPosition();
                rollingRockA.SetActive(true);
                break;
            }
        }
    }
    
    fileprivate func initializeRollingRockA(num:Int){
        for _ in 1...num{
            let tempRock = RollingRockA(position:SpriteServices.GenerateRandomPosition());
            self._enemies.append(tempRock);
        }
    }
}
