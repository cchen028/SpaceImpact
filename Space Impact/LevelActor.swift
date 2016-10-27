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
    fileprivate var _isActive: Bool;
    internal var _level:Int;
    fileprivate var _rollingRockASpawnTimer: Timer?;
    fileprivate var _rollingRockBSpawnTimer: Timer?;
    fileprivate var _eneynySpaceshipASpawnTimer: Timer?;
    fileprivate var _eneynySpaceshipBSpawnTimer: Timer?;
    internal var _levelCreateTimer: Timer?;
    fileprivate var _lblLevel: Label;
    
    internal var _background: SpriteActor?;
    
    
    var Level:Int{get{return self._level} set(val){self._level = val}}
    var Enemies:[ISpaceship]{get{return self._enemies}}
    
    var Items:[ItemActor]{get{return self._items}}
    var IsActive:Bool{get{return self._isActive}}
    
    override init(){
        self._background = SpriteActor(imageName: GeneralGameSettings.BACKGROUND_NAME, positionX: GameScene.instance!.frame.maxX, positionY: GameScene.instance!.frame.minY);
        self._background?.alpha = 0;
        self._background?.zPosition = -20;
        //self._background?.size = GameScene.instance!.frame.size;
        self._enemies = [ISpaceship]();
        self._items = [ItemActor]();
        self._isActive = false;
        self._level = 1;
        self._lblLevel = Label(displayText: "LEVEL ", position: CGPoint(x:GameScene.instance!.frame.midX, y: GameScene.instance!.frame.midY), fontSize: GeneralGameSettings.GAMESCREEN_LEVELLABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
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
    
    func Update(){
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
    }
    
//    func InitializeRollingRockA(num: Int){
//        for _ in 1...num{
//            let tempRock = RollingRockA(position:GameObjectServices.instance.GenerateRandomPosition());
//            self._enemies.append(tempRock);
//        }
//    }
//        
//    func InitializeRollingRockB(num: Int){
//        for _ in 1...num{
//            let tempRock = RollingRockB(position:GameObjectServices.instance.GenerateRandomPosition());
//            self._enemies.append(tempRock);
//        }
//    }
//
//    
//    func InitializeEnemySpaceshipA(num: Int){
//        for _ in 1...num{
//            let tempRock = EnemySpaceshipA(position:GameObjectServices.instance.GenerateRandomPosition());
//            self._enemies.append(tempRock);
//        }
//    }

    
    func ToggleRollingRockA(isOn: Bool, num:Int){
        if(isOn){
            
         //   _rollingRockASpawnTimer = Timer.scheduledTimer(timeInterval: 0, target: cur, selector: NSSelectorFromString(selectorMe), userInfo: nil, repeats: false);
            
            
            _rollingRockASpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKA_SPAWN, target: self, selector: "SpawnRollingRockA", userInfo: num, repeats: true);
        }
        else{
            _rollingRockASpawnTimer!.invalidate();
        }
    }
    
    func ToggleRollingRockB(isOn: Bool, num:Int){
        if(isOn){
            _rollingRockBSpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKB_SPAWN, target: self, selector: "SpawnRollingRockB", userInfo: num, repeats: true);
        }
        else{
            _rollingRockBSpawnTimer!.invalidate();
        }
    }
    
    func ToggleEnemySpaceshipA(isOn: Bool, num:Int){
        if(isOn){
            _eneynySpaceshipASpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKB_SPAWN, target: self, selector: "SpawnEnemySpaceshipA", userInfo: num, repeats: true);
        }
        else{
            _eneynySpaceshipASpawnTimer!.invalidate();
        }
    }
    
    func ToggleEnemySpaceshipB(isOn: Bool, num:Int){
        if(isOn){
            
            _eneynySpaceshipBSpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ENEMYB_SPAWN, target: self, selector: "SpawnEnemySpaceshipB", userInfo: num, repeats: true);
        }
        else{
            _eneynySpaceshipBSpawnTimer!.invalidate();
        }
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
        
        for item in self._items{
            if !item._item.IsActive {
                item.Item.position = GameObjectServices.instance.GenerateRandomPosition();
                item.SetActive(true);
                
            }
        }
        
    }
    
    func SpawnEnemySpaceshipB(){
        var num = 0;
        let total = _eneynySpaceshipBSpawnTimer?.userInfo as? Int
        for obj in self._enemies{
            if var enemySpaceshipB = obj as? EnemySpaceshipB , !enemySpaceshipB.IsActive {
                enemySpaceshipB.Position = GameObjectServices.instance.GenerateRandomPosition();
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
    }
    
    fileprivate func getLevelLabelAction() -> SKAction{
        let fadeInAnimation = SKAction.fadeAlpha(by: 0.8, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let bufferAnimation = SKAction.fadeAlpha(by: 1, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEOUT));
        let sequence = SKAction.sequence([fadeInAnimation,bufferAnimation, fadeOutAnimation]);
        
        return sequence;
    }
}
