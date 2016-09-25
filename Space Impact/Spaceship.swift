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
    
    override func Update(){
        self.spaceshipMovementUpdate();
        self.misslesUpdate();
        
        super.Update();
    }
    
    override func SetActive(_ isActive:Bool){
        self._missleTimer.ToggleMissleTimer(isOn: isActive, targetSpaceship: self);
        super.SetActive(isActive);
    }
    
    override func AddMissle() {
        super.AddMissle();
    }
    
    override func StopMissle(){
        super.StopMissle();
    }
    
    fileprivate func misslesUpdate(){
        if self._missles.count > 0{
            for mIndex in 0...(self._missles.count - 1){
                self._missles[mIndex].Update();
            }
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
            if(self.Spaceship.position.x   < (GameScene.instance!.frame.width - (self.Spaceship.Width / 2)))
            {
                self.Spaceship.position.x  += self.Speed;
            }
        }
    }
    
}

enum MoveDirection:Int{
    case left = -1, none, right
}
