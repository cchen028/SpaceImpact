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
    fileprivate var _life:[Icon];
    fileprivate var _lightning:[Icon];
    
    fileprivate var astroid:SKSpriteNode!;
    fileprivate var astroidAction: SKAction!;
    fileprivate var _level:LevelActor;
    fileprivate var _collidingService:CollidingServices;
    fileprivate var _mySpaceship: Spaceship;
    
    var Name:String{get{return self._name}}
    var Level:LevelActor{get{return self._level}}
    var IsActive:Bool{get{return self._isActive}}
    
    var test:Int = 5000;
    
    override init(){
        self._name = GeneralGameSettings.GAMESCREEN_NAME;
        self._mySpaceship = Spaceship(position:GameObjectServices.instance.GetSpaceshipInitialPos());
        self._isActive = false;
        self._gameScreenNode = SKNode();
        self._gameScreenNode.name = GeneralGameSettings.GAMESCREEN_NAME;
        self._labels = [Label]();
        self._life = [Icon]();
        self._lightning = [Icon]();
        
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
        if UserStatsInfo.instance.Score.value > test{
            self._level.Stop();
            self._level.Level += 1;
            self._level.Start(level:self._level.Level, animationCompleted: nil);
            test = test * 2;
        }
//        for lightning in 0...9{
//            
//            if(lightning <= (UserStatsInfo.instance.Bomb.value - 1)){
//                self._lightning[lightning].FadeIn(customTime: 0.25);
//            }
//            else{
//                self._lightning[lightning].FadeOut(customTime: 0.25);
//            }
//        }
//        
//        for life in 0...9{
//            
//            if(life <= (UserStatsInfo.instance.Life.value - 1)){
//                self._life[life].FadeIn(customTime: 0.25);
//            }
//            else{
//                self._life[life].FadeOut(customTime: 0.25);
//            }
//        }
//
        
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
        
        for lightning in self._lightning{
            lightning.FadeIn();
        }

        for heart in self._life{
            heart.FadeIn();
        }
        
        self._level.Start(level:self._level.Level, animationCompleted: nil);
    }
    
    fileprivate func destroy(){
        self._gameScreenNode.removeFromParent();
        self._mySpaceship.SetActive(false);
        self._level.Stop();
    }
    
//    fileprivate func createLabels(){
//        let lblScore = Label(displayText: "Score: 0", position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
//        
//        UserStatsInfo.instance.Score.bind {
//            lblScore.DisplayText = "Score: " + String($0);
//        }
//        
//        self._labels.append(lblScore);
//         
//        for i in 1...10{
//            let iconBomb = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_BOMB, position: CGPoint(x:20, y:GameScene.instance!.frame.maxY - CGFloat(27 * i)));
//            self._lightning.append(iconBomb);
//        }
//        
//        for i in 1...10{
//            let iconLife = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_LIFE, position: CGPoint(x:GameScene.instance!.frame.maxX - 25, y:GameScene.instance!.frame.maxY - CGFloat(27 * i)));
//            
//            self._life.append(iconLife);
//        }
//        
//    }
    
    fileprivate func createLabels(){
        
        let iconBomb = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_BOMB, position: CGPoint(x:20, y:GameScene.instance!.frame.maxY - 23));
        
        let lblBomb = Label(displayText: "X 3", position: CGPoint(x:55, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        
        let lblLife = Label(displayText: "X 3", position: CGPoint(x:GameScene.instance!.frame.maxX - 25, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        let iconLife = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_LIFE, position: CGPoint(x:GameScene.instance!.frame.maxX - 60, y:GameScene.instance!.frame.maxY - 23));
        
        
        
        let lblScore = Label(displayText: "Score: 0", position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        UserStatsInfo.instance.Score.bind {
            lblScore.DisplayText = "Score: " + String($0);
        }
        
        UserStatsInfo.instance.Life.bind {
            lblLife.DisplayText = "X " + String($0);
        }
        
        UserStatsInfo.instance.Bomb.bind {
            lblBomb.DisplayText = "X " + String($0);
        }

        
        self._labels.append(lblBomb);
        self._labels.append(lblLife);
        self._labels.append(lblScore);
        
        self._life.append(iconLife);
        self._lightning.append(iconBomb);
    }

    
    func HandlesTouch(position: CGPoint, direction:MoveDirection, isTouched:Bool)
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
        
        if((GameConfiguration.instance.MoveMentType == .FreeDrag)){
            let positionX = max(0,min(GameScene.instance!.frame.maxX, self._mySpaceship.Position.x + position.x));
            let positionY = max(0,min(GameScene.instance!.frame.maxY, self._mySpaceship.Position.y + position.y));
            let postion = CGPoint(x:positionX, y:positionY);
            
            self._mySpaceship.Position = postion;
        }
        
        self._mySpaceship.Direction = direction;
    }

    
//    func HandlesTouch(position: CGPoint, direction:MoveDirection, isTouched:Bool)
//    {
//        if !self._isActive
//        {
//            return;
//        }
//        
//        if(!isTouched)
//        {
//            self._mySpaceship.Direction = MoveDirection.none;
//            self._mySpaceship.IsTouched = false;
//            return;
//        }
//        
//        if(self._mySpaceship.Spaceship.frame.contains(position)){
//            self._mySpaceship.IsTouched = true;
//        }
//        
//        if((self._mySpaceship.IsTouched && GameConfiguration.instance.MoveMentType == .FreeDrag)){
//            self._mySpaceship.Position = position;
//        }
//        
//        self._mySpaceship.Direction = direction;
//
//    }
    
    func Notify(_ targetStage:String){}
}
