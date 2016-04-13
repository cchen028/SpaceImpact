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
    private var _gameScreenNode:SKNode;
    private var _name:String;
    private var _gameScene:GameScene;
    private var _isActive:Bool;
    private var _mySpaceShip:Spaceship;
    private var _allOtherObjects:[IActor];
    private var _mySpaceshipMissleTimer: NSTimer!;
    private var rollingRock:RollingRockA;
    
    private var astroid:SKSpriteNode!;
    private var astroidAction: SKAction!;
    
    
    var Name:String{get{return self._name}}
    var MySpaceship:Spaceship{get{return self._mySpaceShip}}
    var IsActive:Bool{get{return self._isActive}}
    
    
    init(gs:GameScene){
        self._name = GeneralGameSettings.GAMESCREEN_NAME;
        self._gameScene = gs;
        self._isActive = false;
        self._gameScreenNode = SKNode();
        self._gameScreenNode.name = GeneralGameSettings.GAMESCREEN_NAME;
        
        let location = CGPoint(x:CGRectGetMidX(self._gameScene.frame), y:CGRectGetMinY(self._gameScene.frame) + 30);
        self._mySpaceShip = Spaceship(gs:self._gameScene, position:location);
        self._allOtherObjects = [IActor]();
        
        rollingRock = RollingRockA(gs:self._gameScene, position:SpriteServices.GenerateRandomPosition());
        _allOtherObjects.append(rollingRock);
    }
    
    func SetActive(isActive: Bool) {
        if(self._isActive == isActive)
        {
            return;
        }
        else{
            self._isActive = isActive;
        }
        
        if(isActive){
            Active();
        }
        else
        {
            InActive();
        }
    }
    
    func Active(){
        
        self._gameScene.addChild(self._gameScreenNode);
        
        self._mySpaceShip.SetActive(true);
        
//        for node in self._gameScene.childNodeWithNodeType(NodeType.GameScreen)!.children{
//          node
//        }
        
        for object in _allOtherObjects{
            object.SetActive(true);
        }
        
//        for object in _allOtherObjects{
//            if(!object.IsActive)
//            {
//                
//            }
//        }
        
    //    _allOtherObjects = _allOtherObjects.filter({(objectt) in objectt.IsActive == false})
        
    }
    
    func InActive() {
        
        self._mySpaceShip.SetActive(false);
        
        for object in _allOtherObjects{
            object.SetActive(false);
        }
        
      //  _allOtherObjects = _allOtherObjects.filter({$0.IsActive});
        
        self._gameScreenNode.removeFromParent();
       // _allOtherObjects = _allOtherObjects.filter({(objectt) in objectt.IsActive == false})
    }
    
    func HandlesTouch(touch: UITouch, withEvent event: UIEvent?, isTouched:Bool)
    {
        if !self._isActive
        {
            return;
        }
        
        if(!isTouched)
        {
            self._mySpaceShip.Direction = MoveDirection.None;
            return;
        }
        
        
        let location = touch.locationInNode(self._gameScene);
        
        if location.x > CGRectGetMidX(self._gameScene.frame){
            self._mySpaceShip.Direction = MoveDirection.Right;
        }
        else
        {
            self._mySpaceShip.Direction = MoveDirection.Left;
        }
        
    }
    
    func Update(){
        self._mySpaceShip.Update(_allOtherObjects);
        
        for object in _allOtherObjects{
            object.Update();
        }
    }
    
    func Notify(targetStage:String){
        
    }
}
