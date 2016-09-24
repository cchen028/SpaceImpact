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
    fileprivate var _moveDirection:MoveDirection;
    fileprivate var _frameCount:CGFloat;
    
    
    var Position:CGPoint{get{return self.Spaceship.position}}
   // var IsActive:Bool{get{return self.Spaceship.IsActive} set(newVal){self.Spaceship.IsActive = newVal}};
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    var Direction:MoveDirection{get{return self._moveDirection} set(val){self._moveDirection = val}}
    
    init(position:CGPoint)
    {
        self._initialPosition = position;
        self._frameCount = 0;
        self._moveDirection = MoveDirection.none;
        
        super.init(imageName: GeneralGameSettings.MYSPACESHIP_NAME, explosionName:GeneralGameSettings.MYSPACESHIP_EXPLOSION, health: 1, speed: GeneralGameSettings.MYSPACESHIP_SPEED, damage: 1, position: position, scale:0.5, type:ActorType.MySpaceship);
        
        
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for _ in 1...25{
            self._missles.append(Missle(position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type:ActorType.MyMissle));
        }
    }
    
    override func Explode() {
        self._explosion.RunAnimation();
    }

    
    func Update(_ objects:[IActor]?){
        self.spaceshipMovementUpdate();
      //  self.mySpaceshipUpdate(objects);
      //  self.myMissleUpdate(objects);
        
        
        super.Update();
        
    }
    
//    func SetActive(_ isActive:Bool){
//        if(self.IsActive != isActive){
//            UpdateStatus(isActive);
//        }
//        self.Spaceship.IsActive = isActive;
//    }
    
    override func UpdateStatus(_ isActive: Bool){
        // Toggles the spaceship missle timer.
        self._missleTimer.ToggleMissleTimer(isOn: isActive, targetSpaceship: self);
        super.UpdateStatus(isActive);
    }
    
    override func AddMissle() {
        super.AddMissle();
    }
    
    override func StopMissle(){
        super.StopMissle();
    }
    
//    fileprivate func mySpaceshipUpdate(_ objects:[IActor]?){
//        if objects != nil{
//            let spaceObjects = objects!;
//            for object in spaceObjects{
//                    if(object.Sprite.Type == ActorType.EnemySpaceship)
//                    {
//                        SelfCollideUpdate(object);
//                    }
//            }
//        }
//    }
    
//    fileprivate func myMissleUpdate(_ objects:[IActor]?){
//        
//        if(self._missles.count <= 0)
//        {
//            return;
//        }
//        
//        for mIndex in 0...(self._missles.count - 1)	{
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
            if(self.Spaceship.position.x   < (GameScene.instance!.frame.width - (self.Spaceship.Width / 2)))
            {
                self.Spaceship.position.x  += self.Speed;
            }
        }
    }
    
//    func SelfCollideUpdate(_ actor: IActor){
//        let collided = self.IsCollideWithSelf(actor.Sprite);
//
//        if(collided)
//        {
//            self.SetActive(false);
//            actor.SetActive(false);
//        }
//    }
    
    
//    func MissleCollideUpdate(_ actor: SpriteActor, missleIndex:Int){
//        let collided = self._missles[missleIndex].IsCollideWithSelf(actor);
//
//        if(collided)
//        {
//            self._missles[missleIndex].SetActive(false);
//            actor.SetActive(false);
//            
//            if let explosionActor = GameScene.instance!.childNode(withName: GeneralGameSettings.GAMESCREEN_NAME)!.childNode(withName: ActorType.Explosion.rawValue+"_"+actor.name!) as? SpriteActor
//            {
//                explosionActor.Explode();
//            }
//        }
//    }
    

}

enum MoveDirection:Int{
    case left = -1, none, right
}
