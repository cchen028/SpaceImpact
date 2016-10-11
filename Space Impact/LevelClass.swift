//
//  Level1.swift
//  Space Impact
//
//  Created by Chieh on 9/21/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class LevelClass: NSObject {
    
    fileprivate var _enemies:[ISpaceship];
    fileprivate var _isActive: Bool;
    fileprivate var _level:Int;
    fileprivate var _rollingRockASpawnTimer: Timer?;
    fileprivate var _lblLevel: Label;
    
    var Enemies:[ISpaceship]{get{return self._enemies}}
    var IsActive:Bool{get{return self._isActive}}
    
    override init(){
        self._enemies = [ISpaceship]();
        self._isActive = false;
        self._level = 0;
        self._lblLevel = Label(displayText: "LEVEL ", position: CGPoint(x:GameScene.instance!.frame.midX, y: GameScene.instance!.frame.midY), fontSize: GeneralGameSettings.GAMESCREEN_LEVELLABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY, opacity: 0);
        super.init();
        self.initializeRollingRockA(num:5);
    }
    
    func StartLevel(level:Int){
        self._level = level;
        self._lblLevel.DisplayText = "LEVEL " + String(level);
        self._lblLevel.LabelNode.run(self.getLevelLabelAction(), completion: {self.EnemySpawnTimer(isOn: true);});
    }
    
    func Destroy(){
        self._level = 0;
        self.EnemySpawnTimer(isOn: false);
        self._enemies = [ISpaceship]();
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
                rollingRockA.Position = GameObjectServices.instance.GenerateRandomPosition();
                rollingRockA.SetActive(true);
                break;
            }
        }
    }
    
    fileprivate func initializeRollingRockA(num:Int){
        for _ in 1...num{
            let tempRock = RollingRockA(position:GameObjectServices.instance.GenerateRandomPosition());
            self._enemies.append(tempRock);
        }
    }
    
    fileprivate func getLevelLabelAction() -> SKAction{
        let fadeInAnimation = SKAction.fadeAlpha(by: 0.8, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let bufferAnimation = SKAction.fadeAlpha(by: 1, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEOUT));
        let sequence = SKAction.sequence([fadeInAnimation,bufferAnimation, fadeOutAnimation]);
        
        return sequence;
    }
}
