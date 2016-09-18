//
//  Spaceship.swift
//  Space Impact
//
//  Created by Chieh on 2/19/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Spaceship: SpaceshipActor, IActor{
    
    fileprivate var _initialPosition:CGPoint;
    fileprivate var _gameScene:GameScene;
    fileprivate var _moveDirection:MoveDirection;
    fileprivate var _frameCount:CGFloat;
    
    
    var Position:CGPoint{get{return self.Spaceship.position}}
    var IsActive:Bool{get{return self.Spaceship.IsActive} set(newVal){self.Spaceship.IsActive = newVal}};
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    var Direction:MoveDirection{get{return self._moveDirection} set(val){self._moveDirection = val}}
    
    init(gs:GameScene, position:CGPoint)
    {
        self._gameScene = gs;
        self._initialPosition = position;
        self._frameCount = 0;
        self._moveDirection = MoveDirection.none;
        
        super.init(gs: gs, imageName: GeneralGameSettings.MYSPACESHIP_NAME, explosionName:GeneralGameSettings.MYSPACESHIP_EXPLOSION, health: 1, speed: GeneralGameSettings.MYSPACESHIP_SPEED, damage: 1, position: position, scale:0.5, type:ActorType.MySpaceship);
        
        
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for _ in 1...25{
            self._missles.append(Missle(gs:self._gameScene, position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type:ActorType.MyMissle));
        }
    }
    
    override func Explode() {
        self._explosion.RunAnimation();
    }

    
    func Update(_ objects:[IActor]?){
        self.spaceshipMovementUpdate();
        self.mySpaceshipUpdate(objects);
        self.myMissleUpdate(objects);
        
        
        super.Update();
        
    }
    
    func SetActive(_ isActive:Bool){
        if(self.Spaceship.IsActive == isActive)
        {
            return;
        }
        else{
            self.Spaceship.IsActive = isActive;
        }
        
        if(isActive){
            Active();
        }
        else
        {
            InActive();
        }
    }
    
    override func AddMissle() {
        
        for i in 0...(_missles.count - 1){
            if(!_missles[i].IsActive){
                _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2));
                _missles[i].SetActive(true);
                break;
            }
        }
        super.AddMissle();
    }
    
    override func Active() {
        self._missleTimer.StartMissle(self);
        super.Active();
    }
    
    override func InActive() {
        self._missleTimer.StopMissle();
        super.InActive();
    }
    
    fileprivate func mySpaceshipUpdate(_ objects:[IActor]?){
        if objects != nil{
            let spaceObjects = objects!;
            for object in spaceObjects{
                    if(object.Sprite.Type == ActorType.EnemySpaceship)
                    {
                        SelfCollideUpdate(object);
                    }
            }
        }
    }
    
    fileprivate func myMissleUpdate(_ objects:[IActor]?){
        
        if(self._missles.count <= 0)
        {
            return;
        }
        
        for mIndex in 0...(self._missles.count - 1)	{
            let missle = self._missles[mIndex];
            missle.Update();
            
            if missle.Missle.position.y > CGFloat(GeneralGameSettings.SCREEN_HEIGHT)
            {
                missle.Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2));
            }
            
           // let spaceObjects = objects!;
           // let spaceObjects = self._gameScene.children;

            let spaceObjects = self._gameScene.childNode(withName: GeneralGameSettings.GAMESCREEN_NAME);
            
           // for object in spaceObjects{
             //   if let gameNode = object as? SKNode {
                    for eachNode in (spaceObjects?.children)!{
                        if let spriteNode = eachNode as? SpriteActor{
                    if(spriteNode.Type == ActorType.EnemySpaceship)
                    {
                        MissleCollideUpdate(spriteNode, missleIndex:mIndex);
                        
                    }
                        }
                    }
                //}
               // else {
                    // obj is not a string array
               // }
              //  if(object.Sprite.Type == ActorType.EnemySpaceship)
              //  {
              //      MissleCollideUpdate(object, missleIndex:mIndex);
              //  }
            //}
        }
    }
    
    fileprivate func spaceshipMovementUpdate(){
        switch self._moveDirection{
        case .left:
            if(self.Spaceship.position.x  > (self.Spaceship.Width / 2))
            {
                self.Spaceship.position.x -= self.Speed;
            }
                break;
        case .none:
            break;
        case .right:
            if(self.Spaceship.position.x  < (self._gameScene.frame.width - (self.Spaceship.Width / 2)))
            {
                self.Spaceship.position.x  += self.Speed;
            }
        }
    }
    
    func SelfCollideUpdate(_ actor: IActor){
     //   let collided =  self.Spaceship.frame.intersects(actor.Sprite.frame);
        let collided = self.IsCollideWithSelf(actor.Sprite);

        if(collided)
        {
            self.SetActive(false);
            actor.SetActive(false);
        }
    }
    
    
    func MissleCollideUpdate(_ actor: SpriteActor, missleIndex:Int){
      //  let collided =  self._missles[missleIndex].Missle.frame.intersects(actor.Sprite.frame);
        let collided = self._missles[missleIndex].IsCollideWithSelf(actor);

        if(collided)
        {
            self._missles[missleIndex].SetActive(false);
            
          //  actor.InActive();
            actor.SetActive(false);
          //  var test = actor.name!;
         //   var test2 = self._gameScene.childNodeWithName("Game")!.childNodeWithName(ActorType.Explosion.rawValue+"_"+actor.name!);
            
            if let explosionActor = self._gameScene.childNode(withName: GeneralGameSettings.GAMESCREEN_NAME)!.childNode(withName: ActorType.Explosion.rawValue+"_"+actor.name!) as? SpriteActor
            {
                explosionActor.Explode();
            }
            
            
            
        }
    }
    

}

enum MoveDirection:Int{
    case left = -1, none, right
}
