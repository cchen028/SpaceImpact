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
    fileprivate var _buttons:[Button];
    fileprivate var _icons:[Icon];
    
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
    
    fileprivate var _levelThres:Int;
    
    override init(){
        self._name = GeneralGameSettings.GAMESCREEN_NAME;
        self._mySpaceship = Spaceship(position:GameObjectServices.instance.GetSpaceshipInitialPos());
        self._isActive = false;
        self._gameScreenNode = SKNode();
        self._gameScreenNode.name = GeneralGameSettings.GAMESCREEN_NAME;
        self._labels = [Label]();
        self._life = [Icon]();
        self._lightning = [Icon]();
        self._icons = [Icon]();
        self._buttons = [Button]();
        self._levelThres = GeneralGameSettings.GAMELEVEL_THRES;
        
        GameObjectServices.instance.CreateGameScreen(gameScreen: self._gameScreenNode);
        
        self._level = LevelClass(userSpaceship: self._mySpaceship);
        self._collidingService = CollidingServices(level: self._level, spaceship: self._mySpaceship);
        super.init();
        self.createLabels();
        self.createButtons();
    }
    
    func Update(_ currentTime: TimeInterval){
        if(!GameObjectServices.instance.IsPaused && !self.Level.IsActive){
            self._level.Resume();
        }
        
        self._level.Update(currentTime);
        self._mySpaceship.Update();
        self._collidingService.Update();
        if UserStatsInfo.instance.Score.value > _levelThres{
            GameObjectServices.instance.HideCollection(lists: self._buttons);
             _levelThres = _levelThres + (Int)((Double)(_levelThres) * 1.3);
            self._level.Stop();
            self._level.Level += 1;
            self._level.Start(level:self._level.Level, animationCompleted: {
                GameObjectServices.instance.ShowCollection(lists: self._buttons);
            });
            
            if(self._level.Level == 6){
                self._level.TransitToBackground(imageName:"galaxy2")
                
            }
        }
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
        
        GameObjectServices.instance.ShowCollection(lists: self._icons);
        GameObjectServices.instance.ShowCollection(lists: self._labels);
        
        self._level.Start(level:self._level.Level, animationCompleted: {
            GameObjectServices.instance.ShowCollection(lists: self._buttons)
        });
    }

    
    fileprivate func destroy(){
        self._gameScreenNode.removeFromParent();
        self._mySpaceship.SetActive(false);
        self._level.Stop();
    }
    
    fileprivate func createButtons(){
        let pauseMenu = Button(displayText: "⊜", position: CGPoint(x:GameScene.instance!.frame.maxX - 10, y:GameScene.instance!.frame.minY + 20), fontName: GeneralGameSettings.BUTTON_FONTFAMILY, fontSize: 40, imageName: "none");
        pauseMenu.LabelNode.LabelNode.zRotation = CGFloat(Double.pi/2);
        pauseMenu.name = "PauseMenu";
        self._buttons.append(pauseMenu);
    }
    
    fileprivate func createLabels(){
        let iconLife = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_LIFE, position: CGPoint(x:20, y:GameScene.instance!.frame.maxY - 23));
        
        let lblLife = Label(displayText: "3", position: CGPoint(x:iconLife.position.x + iconLife.Width, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        let iconBomb = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_BOMB, position: CGPoint(x:lblLife.Position.x + iconLife.Width * 2, y:GameScene.instance!.frame.maxY - 23));
        
        let lblBomb = Label(displayText: "3", position: CGPoint(x:iconBomb.position.x + iconBomb.Width, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        
        let iconGem = Icon(imageName: GeneralGameSettings.GAMESCREEN_ICON_GEM, position: CGPoint(x:lblBomb.Position.x + iconBomb.Width * 2, y:GameScene.instance!.frame.maxY - 23));
        
        let lblGem = Label(displayText: "0", position: CGPoint(x:iconGem.position.x + iconGem.Width, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        let lblScore = Label(displayText: "0", position: CGPoint(x:GameScene.instance!.frame.midX * 1.75, y:GameScene.instance!.frame.maxY - 30), fontSize: GeneralGameSettings.GAMESCREEN_LABEL_FONTSIZE, fontNamed: GeneralGameSettings.GAMESCREEN_LABEL_FONTFAMILY);
        
        UserStatsInfo.instance.Score.bind {
            lblScore.DisplayText = String($0);
        }
        
        UserStatsInfo.instance.Life.bind {
            lblLife.DisplayText = String($0);
        }
        
        UserStatsInfo.instance.Bomb.bind {
            lblBomb.DisplayText = String($0);
        }

        UserStatsInfo.instance.Gem.bind {
            lblGem.DisplayText = String($0);
        }
        
        self._labels.append(lblBomb);
        self._labels.append(lblLife);
        self._labels.append(lblScore);
        self._labels.append(lblGem);
        
        self._icons.append(iconLife);
        self._icons.append(iconBomb);
        self._icons.append(iconGem);
    }
    
    fileprivate func createLabels_backup(){
        
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

    
    func HandlesTouch(position: CGPoint, direction:MoveDirection, isTouched:Bool, multipleTouch:Bool = false, touch: UITouch? = nil, event:UIEvent? = nil)
    {
        if !self._isActive
        {
            return;
        }
        
        
        if((touch) != nil){
            for button in self._buttons{
                if button.IsTouched(touch!, withEvent: event)
                {
                    let curNodeName = button.name == nil ? "" : button.name!;
                    switch curNodeName {
                    case "PauseMenu":
                        GameObjectServices.instance.IsPaused = true;
                        self._mySpaceship.Thruster.isPaused = GameObjectServices.instance.IsPaused;
                        for missle in self._mySpaceship.Missles{
                            missle.Sprite.isPaused = GameObjectServices.instance.IsPaused;
                        }
                        self._mySpaceship.Spaceship.isPaused = GameObjectServices.instance.IsPaused;
                        
                        
                        self._level.Stop();
                        NotificationCenter.default.post(name: .onPauseMenuButtonPressed, object: nil);
                    default:
                        return;
                    }
                }
            }

        }
        
        if(multipleTouch && UserStatsInfo.instance.Bomb.value > 0 && self._mySpaceship.IsActive){
             UserStatsInfo.instance.Bomb.value -= 1;
            _mySpaceship.IsBigLazer = true;
            self._level._background?.FadeInAndOut(customTimeIn: 0.4, customTimeOut: 0.2, animationCompleted: nil);
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
    
    func Notify(_ targetStage:String){}
}
