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
    private var _name:String;
    private var _gameScene:GameScene;
    private var _isActive:Bool;
    private var _mySpaceShip:Spaceship;
    private var _enemySpaceShips:[Spaceship];
    private var _mySpaceshipMissleTimer: NSTimer!;
    
    private var astroid:SKSpriteNode!;
    private var astroidAction: SKAction!;
    
    
    var Name:String{get{return self._name}}
    var MySpaceship:Spaceship{get{return self._mySpaceShip}}
    var IsActive:Bool{get{return self._isActive} set(val)
    {
        self._isActive = val;
        Transition();
        }}
    
    
    init(gs:GameScene){
        self._name = "Game";
        self._gameScene = gs;
        self._isActive = false;
        
        let location = CGPoint(x:CGRectGetMidX(self._gameScene.frame), y:CGRectGetMinY(self._gameScene.frame) + 30);
        self._mySpaceShip = Spaceship(gs:self._gameScene, position:location);
        self._enemySpaceShips = [Spaceship]();
        var rollingRock = RollingRockA(gs:self._gameScene, position:location);
        
        
//        astroid = SKSpriteNode(imageNamed: "astroid1_01.png");
//        astroid.position = CGPoint(x:CGRectGetMidX(self._gameScene.frame), y:CGRectGetMidY(self._gameScene.frame) + 30);
//        self._gameScene.addChild(astroid);
//        
//        let atlas = SKTextureAtlas(named:"astroid1");
//        
//        let anim = SKAction.animateWithTextures([
//            atlas.textureNamed("astroid1_01"),
//            atlas.textureNamed("astroid1_02"),
//            atlas.textureNamed("astroid1_03"),
//            atlas.textureNamed("astroid1_04"),
//            atlas.textureNamed("astroid1_05"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06"),
//            atlas.textureNamed("astroid1_06")
//            ], timePerFrame: 0.1);
//        
//        astroidAction = SKAction.repeatActionForever(anim);
//        
//        astroid.runAction(astroidAction);
        
    }
    
    
    
    func Transition(){
        if !self._isActive{
            self.DeActive();
        }
        else{
            self.Active();
        }
    }
    
    func Active(){
        
        let fadeInAnimation = SKAction.fadeInWithDuration(NSTimeInterval(GeneralGameSettings.TRANSITION_FADEIN));
        
        self._mySpaceShip.Sprite.runAction(fadeInAnimation);
        
        for missle in self._mySpaceShip.Missles{
            missle.Sprite.runAction(fadeInAnimation);
        }
        
        _mySpaceshipMissleTimer = NSTimer.scheduledTimerWithTimeInterval(GeneralGameSettings.MyMissle_Frequency, target: self, selector: "addMissleToSpaceship", userInfo: nil, repeats: true);
    }
    
    func DeActive() {
        let fadeOutAnimation = SKAction.fadeOutWithDuration(NSTimeInterval(GeneralGameSettings.TRANSITION_FADEOUT));
        
        self._mySpaceShip.Sprite.runAction(fadeOutAnimation);
        
        for missle in self._mySpaceShip.Missles{
            missle.Sprite.runAction(fadeOutAnimation);
        }
        
        _mySpaceshipMissleTimer.invalidate();
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
    
    func addMissleToSpaceship(){
        self._mySpaceShip.AddMissle();
    }
    
    func Update(){
        self._mySpaceShip.Update();
    }
    
    func Notify(targetStage:String){
        
    }
    
    


}
