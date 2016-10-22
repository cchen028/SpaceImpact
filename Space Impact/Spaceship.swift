//
//  Spaceship.swift
//  Space Impact
//
//  Created by Chieh on 2/19/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Spaceship: SpaceshipActor{
    
    fileprivate var _initialPosition:CGPoint;
    fileprivate var _moveDirection:MoveDirection;
    fileprivate var _previousMoveDirection:MoveDirection;
    fileprivate var _frameCount:CGFloat;
    fileprivate var _thruster:SpriteActor;
    
    fileprivate var _tiltLeft:SpriteActor;
    fileprivate var _tiltRight:SpriteActor;
    fileprivate var _shield:SpriteActor;
    fileprivate var _shield2:SpriteActor;
    
    fileprivate var _shield1:SpriteActor;
    
   // fileprivate var _shield3:SpriteActor;
    
    fileprivate var _previousMovementIndex: Int;
    
    var Direction:MoveDirection{get{return self._moveDirection} set(val){self._moveDirection = val}}
    
    init(position:CGPoint)
    {
        self._initialPosition = position;
        self._frameCount = 0;
        self._previousMovementIndex = 0;
        self._moveDirection = MoveDirection.none;
        self._previousMoveDirection = MoveDirection.none;
        self._tiltLeft = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_TILTLEFT_NAME, positionX: position.x, positionY: position.y);
        self._tiltRight = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_TILTRIGHT_NAME, positionX: position.x, positionY: position.y);
        
        self._thruster = SpriteActor(imageName: GeneralGameSettings.MYSPACESHIP_THRUSTER_NAME, positionX: position.x, positionY: position.y-25);
        
        //self._shield = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_SHIEDA_NAME, positionX: position.x, positionY: position.y);
        self._shield = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_SHIEDB_NAME, position: position, scale: 1, opacity: 1, type: ActorType.None, repeatCount: -1, startAnimating: false)
        self._shield.zPosition = 15;
        self._shield2 = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_SHIEDB_02_NAME, position: position, scale: 1, opacity: 1, type: ActorType.None, repeatCount: -1, startAnimating: false)
        self._shield2.zPosition = 15;
        self._shield1 = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_SHIEDB_01_NAME, position: position, scale: 1, opacity: 1, type: ActorType.None, repeatCount: -1, startAnimating: false)
        self._shield1.zPosition = 15;
        super.init(imageName: GeneralGameSettings.MYSPACESHIP_NAME, explosionName:GeneralGameSettings.MYSPACESHIP_EXPLOSION, health: 1, speed: GeneralGameSettings.MYSPACESHIP_SPEED, damage: 1, position: position, scale:1, type:ActorType.MySpaceship, isSpaceShipAnimation: false, spaceshipHasAnimation:true);
        self.Health = 1;
        
        
        
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for _ in 1...25{
            self._missles.append(Missle(missleName: GeneralGameSettings.MyMissle_Name, position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type:ActorType.MyMissle));
        }
    }
    
    override func Explode() {
        UserStatsInfo.instance.Life.value -= 1;
        self._thruster.SetActive(false);
        self._tiltLeft.SetActive(false);
        self._tiltRight.SetActive(false);
        
        super.Explode();
    }
    
    override func Update(){
        self.spaceshipMovementUpdate();
        self.animateSpaceship();
        self.shieldUpdate(health:self.Health);
        
        self._tiltLeft.SyncPositionWith(actor: self.Spaceship);
        self._tiltRight.SyncPositionWith(actor: self.Spaceship);
        
        self._shield2.SyncPositionWith(actor: self.Spaceship);
        self._shield1.SyncPositionWith(actor: self.Spaceship);
        self._shield.SyncPositionWith(actor: self.Spaceship);
        self._thruster.SyncPositionWith(actor: self.Spaceship, offsetX:0,offsetY:-25);
        
        
        super.Update();
    }
    
    override func SetActive(_ isActive:Bool){
        self._missleTimer.ToggleMissleTimer(isOn: isActive, targetSpaceship: self, missleFz: GeneralGameSettings.MyMissle_Frequency);
        self._thruster.SetActive(isActive);
        self._tiltLeft.SetActive(isActive);
        self._tiltRight.SetActive(isActive);
        self._shield.SetActive(isActive);
        self._shield1.SetActive(isActive);
        self._shield2.SetActive(isActive);
        self._shield2.RunAnimation {};
        self._shield1.RunAnimation {};
        self._shield.RunAnimation {};
        self._shield2.alpha = 0;
        self._shield1.alpha = 0;
        self._shield.alpha = 0;
        super.SetActive(isActive);
    }
    
    override func AddMissle() {
        super.AddMissle();
    }
    
    override func StopMissle(){
        super.StopMissle();
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
    
    fileprivate func shieldUpdate(health:Int){
        if health == 4, self._shield2.alpha != CGFloat(1){
            // self._shield2.SetActive(true);
            self._shield2.alpha = 1;
            self._shield1.alpha = 0;
            self._shield.alpha = 0;
            self._shield2.RunAnimation {};
            
        }
        else if health  == 3, self._shield.alpha != CGFloat(1){
            //self._shield.SetActive(true);
            self._shield2.alpha = 0;
            self._shield1.alpha = 0;
            self._shield.alpha = 1;
            self._shield.RunAnimation {};
            
        }
        else if health == 2, self._shield1.alpha != CGFloat(1){
            // self._shield1.SetActive(true)1
            self._shield2.alpha = 0;
            self._shield1.alpha = 1;
            self._shield.alpha = 0;
            self._shield1.RunAnimation {};
        }
        else if health == 1{
            // self._shield1.SetActive(true)1
            self._shield2.alpha = 0;
            self._shield1.alpha = 0;
            self._shield.alpha = 0;
            //self._shield1.RunAnimation {};
        }

    }
    
    fileprivate func animateSpaceship(){
        
        switch self._moveDirection{
        case .left:
            if(!self._tiltLeft.hasActions() && self._previousMoveDirection != .left){
                
                self.Spaceship.alpha = 0;
                self._tiltLeft.alpha = 1;
                self._tiltRight.alpha = 0;
                self._tiltLeft.RunAnimation(animationComplete: {});
            }
            
            self._previousMoveDirection = .left;
            break;
        case .none:
            if(!self._tiltRight.hasActions() && !self._tiltLeft.hasActions())
            {
                if(self._previousMoveDirection == .left)
                {
                    self._tiltLeft.RunReverseAnimation(animationComplete: {});
                }
                
                if(self._previousMoveDirection == .right)
                {
                    self._tiltRight.RunReverseAnimation(animationComplete: {});
                }
                
                self._previousMoveDirection = .none;
            }
            break;
        case .right:
            if(!self._tiltRight.hasActions() && self._previousMoveDirection != .right){
                self.Spaceship.alpha = 0;
                self._tiltLeft.alpha = 0;
                self._tiltRight.alpha = 1;
                self._tiltRight.RunAnimation(animationComplete: {});
            }
            
            self._previousMoveDirection = .right;
        }
    }
    
}

enum MoveDirection:Int{
    case left = -1, none, right
}
