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
        self._mySpaceship = Spaceship(position:SpriteServices.GetSpaceshipInitialPos());
        self._isActive = false;
        self._gameScreenNode = SKNode();
        self._gameScreenNode.name = GeneralGameSettings.GAMESCREEN_NAME;
        
        GameObjectServices.instance.CreateGameScreen(gameScreen: self._gameScreenNode);
        
        self._level = LevelClass();
        self._collidingService = CollidingServices(level: self._level, spaceship: self._mySpaceship);
        super.init();
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
    }
    
    fileprivate func create(){
        GameScene.instance!.addChild(self._gameScreenNode);
        self._mySpaceship.SetActive(true);
        self._level.SetActive(true);
        self._isActive = true;
        
    }
    
    fileprivate func destroy(){
        self._gameScreenNode.removeFromParent();
        self._mySpaceship.SetActive(false);
        self._level.SetActive(false);
        self._isActive = false;
        
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
