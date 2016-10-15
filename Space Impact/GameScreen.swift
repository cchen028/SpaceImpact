//
//  GameScreen.swift
//  Space Impact
//
//  Created by Chieh on 2/28/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class GameScreen: NSObject,IStage {
    fileprivate var _gameScreenNode:SKNode;
    fileprivate var _name:String;
    fileprivate var _isActive:Bool;
    fileprivate var _mySpaceshipMissleTimer: Timer!;
    fileprivate var _labels:[Label];
    fileprivate var _icons:[Icon];
    
    fileprivate var astroid:SKSpriteNode!;
    fileprivate var astroidAction: SKAction!;
    fileprivate var _level:LevelClass;
    fileprivate var _collidingService:CollidingServices;
    fileprivate var _mySpaceship: Spaceship;
    
    var Name:String{get{return self._name}}
    var Level:LevelClass{get{return self._level}}
    var IsActive:Bool{get{return self._isActive}}
    
    override init(){
        self._name = GeneralGameSettings.GAMESCREEN_NAME;
        self._mySpaceship = Spaceship(position:GameObjectServices.instance.GetSpaceshipInitialPos());
        self._isActive = false;
        self._gameScreenNode = SKNode();
        self._gameScreenNode.name = GeneralGameSettings.GAMESCREEN_NAME;
        self._labels = [Label]();
        self._icons = [Icon]();
        
        GameObjectServices.instance.CreateGameScreen(gameScreen: self._gameScreenNode);
        
        self._level = LevelClass();
        self._collidingService = CollidingServices(level: self._level, spaceship: self._mySpaceship);
        super.init();
        self.createLabels();
    }
    
    func Update(){
        self._level.Update();
        self._mySpaceship.Update();
        self._collidingService.Update();
    }
    
    func SetActive(_ isActive: Bool) {
        if(isActive){
            self.create();
        }
        else{
            self.destroy();
        }
        
        self._isActive = isActive;
    }
    
    fileprivate func create(){
        GameScene.instance!.addChild(self._gameScreenNode);
        self._mySpaceship.SetActive(true);
        
        
        for label in self._labels{
            label.FadeIn();
        }
        
        for icon in self._icons{
            icon.FadeIn();
        }
        
        self._level.StartLevel(level: 1);
    }
    
    fileprivate func destroy(){
        self._gameScreenNode.removeFromParent();
        self._mySpaceship.SetActive(false);
        self._level.Destroy();
    }
    
    fileprivate func createLabels(){
        
        let iconBomb = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_BOMB, position: CGPoint(x:20, y:GameScene.instance!.frame.maxY - 20));

        let lblBomb = Label(displayText: "X 3", position: CGPoint(x:50, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        let iconLife = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_LIFE, position: CGPoint(x:100, y:GameScene.instance!.frame.maxY - 20));
        
        
        let lblLife = Label(displayText: "X 3", position: CGPoint(x:135, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        let lblScore = Label(displayText: "Score: 0", position: CGPoint(x:250, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        UserStatsInfo.instance.Score.bind {
            lblScore.DisplayText = "Score: " + String($0);
        }
        
        UserStatsInfo.instance.Life.bind {
            lblLife.DisplayText = "X " + String($0);
        }
        
        self._labels.append(lblBomb);
        self._labels.append(lblLife);
        self._labels.append(lblScore);
        
        self._icons.append(iconLife);
        self._icons.append(iconBomb);
    }

    func HandlesTouch(_ touch: UITouch, withEvent event: UIEvent?, isTouched:Bool)
    {
        if !self._isActive
        {
            return;
        }
        
        if(!isTouched)
        {
            self._mySpaceship.Direction = MoveDirection.none;
            return;
        }
        
        let location = touch.location(in: GameScene.instance!);
        
        if location.x > GameScene.instance!.frame.midX{
            self._mySpaceship.Direction = MoveDirection.right;
        }
        else
        {
            self._mySpaceship.Direction = MoveDirection.left;
        }
    }
    
    func Notify(_ targetStage:String){}
}
