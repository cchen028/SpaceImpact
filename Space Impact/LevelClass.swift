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
    fileprivate var _items:[ItemActor];
    fileprivate var _isActive: Bool;
    fileprivate var _level:Int;
    fileprivate var _rollingRockASpawnTimer: Timer?;
    fileprivate var _rollingRockBSpawnTimer: Timer?;
    fileprivate var _eneynySpaceshipASpawnTimer: Timer?;
    fileprivate var _lblLevel: Label;
    
    var Enemies:[ISpaceship]{get{return self._enemies}}
    
    var Items:[ItemActor]{get{return self._items}}
    var IsActive:Bool{get{return self._isActive}}
    
    override init(){
        self._enemies = [ISpaceship]();
        self._items = [ItemActor]();
        self._isActive = false;
        self._level = 0;
        self._lblLevel = Label(displayText: "LEVEL ", position: CGPoint(x:GameScene.instance!.frame.midX, y: GameScene.instance!.frame.midY), fontSize: GeneralGameSettings.GAMESCREEN_LEVELLABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        super.init();
        self.initializeRollingRockA(num:10);
        self.initializeItems();
    }
    
    func StartLevel(level:Int){
        self._level = level;
        self._lblLevel.DisplayText = "LEVEL " + String(level);
        self._lblLevel.FadeInAndOut(animationCompleted: {self.EnemySpawnTimer(isOn: true);});
    }
    
    func Destroy(){
        self._level = 0;
        self.EnemySpawnTimer(isOn: false);
        self._enemies = [ISpaceship]();
    }
    
    func EnemySpawnTimer(isOn:Bool){
        if(isOn){
            _rollingRockASpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKA_SPAWN, target: self, selector: "SpawnRollingRockA", userInfo: nil, repeats: true);
            _rollingRockBSpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKB_SPAWN, target: self, selector: "SpawnRollingRockB", userInfo: nil, repeats: true);
            _eneynySpaceshipASpawnTimer = Timer.scheduledTimer(timeInterval: GeneralGameSettings.ROLLINGROCKB_SPAWN, target: self, selector: "SpawnEnemySpaceshipA", userInfo: nil, repeats: true);
        }
        else{
            _rollingRockASpawnTimer!.invalidate();
            _rollingRockBSpawnTimer!.invalidate();
            _rollingRockASpawnTimer = nil;
        }
    }
    
    func Update(){
        for obj in self._enemies{
            if let rollingRockA = obj as? SpaceshipActor, rollingRockA.Type == ActorType.EnemySpaceship {
                rollingRockA.Update();
            }
        }
        
        for obj in self._items{
            if let item = obj as? ItemActor{
                item.Update();
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
    
    func SpawnRollingRockB(){
        
        for obj in self._enemies{
            if var rollingRockB = obj as? RollingRockB , !rollingRockB.IsActive {
                rollingRockB.Position = GameObjectServices.instance.GenerateRandomPosition();
                rollingRockB.SetActive(true);
                break;
            }
        }
    }
    func SpawnEnemySpaceshipA(){
        
        for obj in self._enemies{
            if var enemySpaceshipA = obj as? EnemySpaceshipA , !enemySpaceshipA.IsActive {
                enemySpaceshipA.Position = GameObjectServices.instance.GenerateRandomPosition();
                enemySpaceshipA.SetActive(true);
                break;
            }
        }
        
        for item in self._items{
            if !item._item.IsActive {
                item.Item.position = GameObjectServices.instance.GenerateRandomPosition();
                item.SetActive(true);
                
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

    }
    
    fileprivate func getLevelLabelAction() -> SKAction{
        let fadeInAnimation = SKAction.fadeAlpha(by: 0.8, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let bufferAnimation = SKAction.fadeAlpha(by: 1, duration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEIN));
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(GeneralGameSettings.GAMESCREEN_LEVELLABEL_FADEOUT));
        let sequence = SKAction.sequence([fadeInAnimation,bufferAnimation, fadeOutAnimation]);
        
        return sequence;
    }
}
