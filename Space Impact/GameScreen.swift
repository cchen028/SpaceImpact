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
       // GameObjectServices.instance.CreateSpaceShip();
        self._level = LevelClass();
        //self._mySpaceship = GameObjectServices.instance.PlayerSpaceship!;
        self._collidingService = CollidingServices(level: self._level, spaceship: self._mySpaceship);
        
        //GameObjectServices.instance.CreateRollingRockA(num: 25);
       // GameObjectServices.instance.CreateSpaceShip();
        
        
        super.init();
        
    }
    
    func SetActive(_ isActive: Bool) {
        
        if(self._isActive != isActive){
            UpdateStatus(isActive);
        }
        
    }
    
    func UpdateStatus(_ isActive: Bool){
        if(!isActive){
            self._gameScreenNode.removeFromParent();
        }
        else
        {
            GameScene.instance!.addChild(self._gameScreenNode);
        }
        
        self._mySpaceship.SetActive(isActive);
        //GameObjectServices.instance.PlayerSpaceship!.SetActive(isActive);
        
//        for obj in self._level.Enemies{
//            if let rollingRockA = obj as? RollingRockA {
//                rollingRockA.SetActive(isActive);
//            }
//        }
        
        self._level.UpdateStatus(isActive);
        
        self._isActive = isActive;
       
    }
    
    func SpaceshipAndEnemyCollisionUpdate(){
        let objects = self._level.Enemies;
        //  if objects != nil{
        //     let spaceObjects = objects!;
        for object in objects{
            if(object.Sprite.Type == ActorType.EnemySpaceship)
            {
                self.SelfCollideUpdate(spaceActor: object);
            }
        }
        // }
    }
    
    fileprivate func SelfCollideUpdate(spaceActor: IActor){
        let collided = self.IsCollideWithSelf(spaceActor.Sprite);
        
        if(collided)
        {
            self._mySpaceship.SetActive(false);
            //GameObjectServices.instance.PlayerSpaceship!.SetActive(false);
            //self.SetActive(false);
            spaceActor.SetActive(false);
        }
    }
    
    fileprivate func IsCollideWithSelf(_ actor: SpriteActor) -> Bool{
        //self._mySpaceship
        //return GameObjectServices.instance.PlayerSpaceship!.Sprite.frame.intersects(actor.frame);
        return self._mySpaceship.Sprite.frame.intersects(actor.frame);
    }


    
//    func Active(){
//        GameScene.instance!.addChild(self._gameScreenNode);
//        
//        for obj in GameObjectServices.instance.RollingRock{
//            if let rollingRockA = obj as? RollingRockA {
//                rollingRockA.SetActive(true);
//            }
//        }
//        
//        GameObjectServices.instance.PlayerSpaceship!.SetActive(true);
//    }
//    
//    func InActive() {
//        GameObjectServices.instance.PlayerSpaceship!.SetActive(false);
//        
//        for obj in GameObjectServices.instance.RollingRock{
//            if let rollingRockA = obj as? RollingRockA {
//                rollingRockA.SetActive(false);
//            }
//        }
//        
//        self._gameScreenNode.removeFromParent();
//    }
    
    func HandlesTouch(_ touch: UITouch, withEvent event: UIEvent?, isTouched:Bool)
    {
        if !self._isActive
        {
            return;
        }
        
        if(!isTouched)
        {
            self._mySpaceship.Direction = MoveDirection.none;
           // GameObjectServices.instance.PlayerSpaceship!.Direction = MoveDirection.none;
            return;
        }
        
        
        let location = touch.location(in: GameScene.instance!);
        
        if location.x > GameScene.instance!.frame.midX{
            self._mySpaceship.Direction = MoveDirection.right;
            //GameObjectServices.instance.PlayerSpaceship!.Direction = MoveDirection.right;
        }
        else
        {
            self._mySpaceship.Direction = MoveDirection.left;
           // GameObjectServices.instance.PlayerSpaceship!.Direction = MoveDirection.left;
        }
        
    }
    
    func Update(){
        
       // self.SpaceshipAndEnemyCollisionUpdate();
       // CollidingServices.SpaceshipAndEnemyCollisionUpdate();
       // CollidingServices.SpaceshipMissleUpdate();
      //  self.myMissleUpdate(objects);
       // self.mySpaceshipUpdate(objects);
        
      // CollidingServices.SpaceshipAndEnemyCollisionUpdate();
        
        // GameObjectServices.instance.PlayerSpaceship!.Update(self._level.Enemies);
        
        self._level.Update();
        self._mySpaceship.Update(self._level.Enemies);
        //self.myMissleUpdate();
      //  self.myMissleUpdate();
        self._collidingService.Update();
        
//        for obj in GameObjectServices.instance.RollingRock{
//            if let rollingRockA = obj as? RollingRockA {
//                rollingRockA.Update();
//            }
//        }
    }
    
//    fileprivate func mySpaceshipUpdate(_ objects:[IActor]?){
//        if objects != nil{
//            let spaceObjects = objects!;
//            for object in spaceObjects{
//                if(object.Sprite.Type == ActorType.EnemySpaceship)
//                {
//                    SelfCollideUpdate(object);
//                }
//            }
//        }
//    }
 
    
    
        fileprivate func myMissleUpdate(){
    
            if(self._mySpaceship._missles.count <= 0)
            {
                return;
            }
            
            
            let spaceObjects = GameScene.instance!.childNode(withName: GeneralGameSettings.GAMESCREEN_NAME);
    
            for mIndex in 0...(self._mySpaceship._missles.count - 1)	{
                let missle = self._mySpaceship._missles[mIndex];
                missle.Update();
    
    
                for eachNode in (spaceObjects?.children)!{
                    if let spriteNode = eachNode as? SpriteActor{
                        if(spriteNode.Type == ActorType.EnemySpaceship)
                        {
                            MissleCollideUpdate(spriteNode, missleIndex:mIndex);
                        }
                    }
                }
            }
        }

    fileprivate func MissleCollideUpdate(_ actor: SpriteActor, missleIndex:Int){
        let collided = self._mySpaceship._missles[missleIndex].IsCollideWithSelf(actor);
        
        if(collided)
        {
            self._mySpaceship._missles[missleIndex].SetActive(false);
            actor.SetActive(false);
            
            if let explosionActor = GameScene.instance!.childNode(withName: GeneralGameSettings.GAMESCREEN_NAME)!.childNode(withName: ActorType.Explosion.rawValue+"_"+actor.name!) as? SpriteActor
            {
                explosionActor.Explode();
            }
        }
    }
    
    
//    fileprivate func myMissleUpdate(_ objects:[IActor]?){
//        
//        if(self._mySpaceship._missles.count <= 0)
//        {
//            return;
//        }
//        
//        for mIndex in 0...(self._mySpaceship._missles.count - 1)	{
//            let missle = self._missles[mIndex];
//            missle.Update();
//            
//            let spaceObjects = GameScene.instance!.childNode(withName: GeneralGameSettings.GAMESCREEN_NAME);
//            
//            for eachNode in (spaceObjects?.children)!{
//                if let spriteNode = eachNode as? SpriteActor{
//                    if(spriteNode.Type == ActorType.EnemySpaceship)
//                    {
//                        MissleCollideUpdate(spriteNode, missleIndex:mIndex);
//                    }
//                }
//            }
//        }
//    }
    
    
//    func SelfCollideUpdate(_ actor: IActor){
//        let collided = self.IsCollideWithSelf(actor.Sprite);
//        
//        if(collided)
//        {
//            self.SetActive(false);
//            actor.SetActive(false);
//        }
//    }
//    
//    func IsCollideWithSelf(_ actor: SpriteActor) -> Bool{
//        return self.Spaceship.frame.intersects(actor.frame);
//    }
    
    func Notify(_ targetStage:String){
        
    }
}
