//
//  LevelActor.swift
//  Space Impact
//
//  Created by Chieh on 10/24/16.
//  Copyright © 2016 Jay. All rights reserved.
//

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

class LevelActor: NSObject {
    
    fileprivate var _enemies:[ISpaceship];
    fileprivate var _items:[ItemActor];
    internal var _isActive: Bool;
    internal var _level:Int;
    fileprivate var _bossSpawnTimer: Timer?;
    fileprivate var _rollingRockASpawnTimer: Timer?;
    fileprivate var _rollingRockBSpawnTimer: Timer?;
    fileprivate var _eneynySpaceshipASpawnTimer: Timer?;
    fileprivate var _eneynySpaceshipBSpawnTimer: Timer?;
    internal var _levelCreateTimer: Timer?;
    fileprivate var _lblLevel: Label;
    internal var _background: SpriteActor?;
    fileprivate var _itemScore: Int;
    
    
    var _enemySpaceshipBTimer:SpawnTimer?;
    
    
    var Level:Int{get{return self._level} set(val){self._level = val}}
    var Enemies:[ISpaceship]{get{return self._enemies}}
    
    var Items:[ItemActor]{get{return self._items}}
    var IsActive:Bool{get{return self._isActive}}
    var Background:SpriteActor?{get{return self._background} set(val){self._background = val}};
    
    override init(){
        self._background = SpriteActor(imageName: GeneralGameSettings.BACKGROUND_NAME, positionX: GameScene.instance!.frame.maxX, positionY: GameScene.instance!.frame.minY);
        self._background?.alpha = 0;
        self._background?.zPosition = -20;
        self._enemies = [ISpaceship]();
        self._items = [ItemActor]();
        self._isActive = false;
        self._level = 1;
        self._lblLevel = Label(displayText: "LEVEL ", position: CGPoint(x:GameScene.instance!.frame.midX, y: GameScene.instance!.frame.midY), fontSize: GeneralGameSettings.GAMESCREEN_LEVELLABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        self._enemySpaceshipBTimer = SpawnTimer(interval: 3000);
        self._itemScore = GeneralGameSettings.ITEM_SCORE_THRES;
        
        super.init();
        
        self.initializeRollingRockA(num:20);
        self.initializeItems();
    }
    
   
    
    func Start(level:Int, animationCompleted: ((() -> Void)?)){
       //s self._background?.SetActive(true);
        self._background?.FadeIn();
        self._level = level;
        
        self._lblLevel.DisplayText = "LEVEL " + String(level);
        self._lblLevel.FadeInAndOut(animationCompleted: animationCompleted);
    }
    
    func Stop(){
        _rollingRockASpawnTimer?.invalidate();
        _rollingRockBSpawnTimer?.invalidate();
        _eneynySpaceshipASpawnTimer?.invalidate();
        _eneynySpaceshipBSpawnTimer?.invalidate();
        _levelCreateTimer?.invalidate();
        
    }
    
    func Update(_ currentTime: TimeInterval){
        for obj in self._enemies{
            if let enemy = obj as? SpaceshipActor {
                enemy.Update();
            }
        }
        
        for obj in self._items{
            if let item = obj as? ItemActor{
                item.Update();
            }
        }
        
        //for item in self._items{
            if UserStatsInfo.instance.Score.value > self._itemScore {
                var item = self._items[GameObjectServices.instance.GetRandomNumber(endRange: 4, zeroBase: true)];
                item.Item.position = GameObjectServices.instance.GenerateRandomPosition();
                item.SetActive(true);
                self._itemScore += GeneralGameSettings.ITEM_SCORE_THRES;
            }
        //}
    }
    
    func ToggleRollingRockA(isOn: Bool, num:Int){
        if(isOn){
            _rollingRockASpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKA_SPAWN, target: self, selector:  #selector(LevelActor.SpawnRollingRockA), userInfo: num, repeats: true);
        }
        else{
            _rollingRockASpawnTimer!.invalidate();
        }
    }
    
    func ToggleRollingRockB(isOn: Bool, num:Int){
        if(isOn){
            _rollingRockBSpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKB_SPAWN, target: self, selector: #selector(LevelActor.SpawnRollingRockB), userInfo: num, repeats: true);
        }
        else{
            _rollingRockBSpawnTimer!.invalidate();
        }
    }
    
    func ToggleEnemySpaceshipA(isOn: Bool, num:Int){
        if(isOn){
            _eneynySpaceshipASpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKB_SPAWN, target: self, selector: #selector(LevelActor.SpawnEnemySpaceshipA), userInfo: num, repeats: true);
        }
        else{
            _eneynySpaceshipASpawnTimer!.invalidate();
        }
    }
    
    func ToggleEnemySpaceshipB(isOn: Bool, num:Int){
        if(isOn){
            
            _eneynySpaceshipBSpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ENEMYB_SPAWN, target: self, selector: #selector(LevelActor.SpawnEnemySpaceshipB), userInfo: num, repeats: true);
        }
        else{
            _eneynySpaceshipBSpawnTimer!.invalidate();
        }
    }
    
    func ToggleBoss(playerSpaceship:Spaceship){
        _bossSpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ENEMYB_SPAWN, target: self, selector: #selector(LevelActor.SpawnBoss), userInfo: playerSpaceship, repeats: false);
    }
    
    func SpawnRollingRockA(){
        var num = 0;
        let total = _rollingRockASpawnTimer?.userInfo as? Int
        
        for obj in self._enemies{
            if var rollingRockA = obj as? RollingRockA , !rollingRockA.IsActive {
                rollingRockA.Position = GameObjectServices.instance.GenerateRandomPosition();
                rollingRockA.SetActive(true);
                num += 1;
                if(total == nil || num == total)
                {
                    break;
                }
            }
        }
    }
    
    func SpawnRollingRockB(){
        var num = 0;
        let total = _rollingRockBSpawnTimer?.userInfo as? Int
        for obj in self._enemies{
            if var rollingRockB = obj as? RollingRockB , !rollingRockB.IsActive {
                rollingRockB.Position = GameObjectServices.instance.GenerateRandomPosition();
                rollingRockB.SetActive(true);
                num += 1;
                if(total == nil || num == total)
                {
                    break;
                }
            }
        }
    }
    
    func SpawnEnemySpaceshipA(){
        var num = 0;
        let total = _eneynySpaceshipASpawnTimer?.userInfo as? Int
        for obj in self._enemies{
            if var enemySpaceshipA = obj as? EnemySpaceshipA , !enemySpaceshipA.IsActive {
                enemySpaceshipA.Position = GameObjectServices.instance.GenerateRandomPosition();
                enemySpaceshipA.SetActive(true);
                num += 1;
                if(total == nil || num == total)
                {
                    break;
                }
            }
        }
    }
    
    func SpawnBoss(){
        let playerSpaceship = _bossSpawnTimer?.userInfo as? Spaceship
        for obj in self._enemies{
            if var boss = obj as? Boss , !boss.IsActive {
                boss.Position = GameObjectServices.instance.GenerateRandomPosition();
                boss.Target = playerSpaceship;
                boss.SetActive(true);
                break;
            }
        }
    }
    
    func SpawnEnemySpaceshipB(){
        var num = 0;
        let total = _eneynySpaceshipBSpawnTimer?.userInfo as? Int
        for obj in self._enemies{
            if var enemySpaceshipB = obj as? EnemySpaceshipB , !enemySpaceshipB.IsActive {
                enemySpaceshipB.Position = GameObjectServices.instance.GenerateRandomPositionFromSide();
                enemySpaceshipB.SetActive(true);
                num += 1;
                if(total == nil || num == total)
                {
                    break;
                }
            }
        }
    }
    
    
    
    
    fileprivate func initializeItems(){
        let tempItem = Item(atlasItemName: GeneralGameSettings.ITEM_SHIELD_NAME, exposionName: GeneralGameSettings.ITEM_CAPTUREB_NAME, position: GameObjectServices.instance.GenerateRandomPosition(), itemType: ActorType.ItemShield);
        self._items.append(tempItem);
        
        let tempItem2 = Item(atlasItemName: GeneralGameSettings.ITEM_LIGHTNING_NAME, exposionName: GeneralGameSettings.ITEM_CAPTUREA_NAME, position: GameObjectServices.instance.GenerateRandomPosition(), itemType: ActorType.ItemLightning);
        self._items.append(tempItem2);
        
        let tempItem3 = Item(atlasItemName: GeneralGameSettings.ITEM_HEART_NAME, exposionName: GeneralGameSettings.ITEM_CAPTUREC_NAME, position: GameObjectServices.instance.GenerateRandomPosition(), itemType: ActorType.ItemHeart);
        self._items.append(tempItem3);
        
        let tempItem4 = Item(atlasItemName: GeneralGameSettings.ITEM_MISSLEUPGRADE_NAME, exposionName: GeneralGameSettings.ITEM_CAPTURED_NAME, position: GameObjectServices.instance.GenerateRandomPosition(), itemType: ActorType.ItemMissleUpgrade);
        self._items.append(tempItem4);
        
        
    }
    
    fileprivate func initializeRollingRockA(num:Int){
        for _ in 1...num{
            let tempRock = RollingRockA(position:GameObjectServices.instance.GenerateRandomPosition());
            self._enemies.append(tempRock);
        }
        
        for _ in 1...num{
            let tempRock = RollingRockB(position:GameObjectServices.instance.GenerateRandomPosition());
            self._enemies.append(tempRock);
        }
        
        for _ in 1...num{
            let tempRock = EnemySpaceshipA(position:GameObjectServices.instance.GenerateRandomPosition());
            self._enemies.append(tempRock);
        }
        
        for _ in 1...num{
            let tempRock = EnemySpaceshipB(position:GameObjectServices.instance.GenerateRandomPosition());
            self._enemies.append(tempRock);
        }
        
        let tempBoss = Boss(position:GameObjectServices.instance.GenerateRandomPosition());
        self._enemies.append(tempBoss);
    }
    
    fileprivate func getLevelLabelAction() -> SKAction{
        let fadeInAnimation = SKAction.fadeAlpha(by: 0.8, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let bufferAnimation = SKAction.fadeAlpha(by: 1, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEOUT));
        let sequence = SKAction.sequence([fadeInAnimation,bufferAnimation, fadeOutAnimation]);
        
        return sequence;
    }
}

