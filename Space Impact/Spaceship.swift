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
    fileprivate var _isTouched:Bool;
    fileprivate var _frameCount:CGFloat;
    fileprivate var _thruster:SpriteActor;
    fileprivate var _tiltLeft:SpriteActor;
    fileprivate var _tiltRight:SpriteActor;
    fileprivate var _shield:SpriteActor;
    fileprivate var _shield2:SpriteActor;
    fileprivate var _shield1:SpriteActor;
    fileprivate var _respawnTimer: Timer?;
    fileprivate var _invincibleTimer: Timer?;
    fileprivate var _isBigLazer: Bool;
    
    fileprivate var _isInvincible:Bool;
    fileprivate var _invicibleDim:Bool;
    fileprivate var _alpha: CGFloat;
    
    
    fileprivate var _previousMovementIndex: Int;
    
    var Thruster:SpriteActor{get{return self._thruster}}
    var RespawnTimer: Timer?;
    var Direction:MoveDirection{get{return self._moveDirection} set(val){self._moveDirection = val}}
    var IsTouched:Bool{get{return self._isTouched} set(val){self._isTouched = val}}
    var IsInvincible:Bool{get{return self._isInvincible} set(val){self._isInvincible = val}}
    var IsBigLazer:Bool{get{return self._isBigLazer} set(val){self._isBigLazer = val}}
    
    init(position:CGPoint)
    {
        self._initialPosition = position;
        self._frameCount = 0;
        self._previousMovementIndex = 0;
        self._moveDirection = MoveDirection.none;
        self._previousMoveDirection = MoveDirection.none;
        self._tiltLeft = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_TILTLEFT_NAME, positionX: position.x, positionY: position.y);
        self._tiltRight = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_TILTRIGHT_NAME, positionX: position.x, positionY: position.y);
        self._isTouched = false;
        self._isBigLazer = false;
        self._thruster = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_THRUSTER, position: CGPoint(x:position.x, y:position.y-20), scale: 1, opacity: 1, type: ActorType.None, repeatCount: -1, startAnimating: true)
        
        self._shield = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_SHIEDB_NAME, position: position, scale: 1, opacity: 1, type: ActorType.None, repeatCount: -1, startAnimating: false)
        self._shield.zPosition = 15;
        self._shield2 = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_SHIEDB_02_NAME, position: position, scale: 1, opacity: 1, type: ActorType.None, repeatCount: -1, startAnimating: false)
        self._shield2.zPosition = 15;
        self._shield1 = SpriteActor(atlasName: GeneralGameSettings.MYSPACESHIP_SHIEDB_01_NAME, position: position, scale: 1, opacity: 1, type: ActorType.None, repeatCount: -1, startAnimating: false)
        self._shield1.zPosition = 15;
        self._isInvincible = false;
        self._invicibleDim = false;
        self._alpha = 0;
        super.init(imageName: GeneralGameSettings.MYSPACESHIP_NAME, explosionName:GeneralGameSettings.MYSPACESHIP_EXPLOSION, health: 1, speed: GeneralGameSettings.MYSPACESHIP_SPEED, damage: 1, position: position, scale:1, type:ActorType.MySpaceship, missleType: ActorType.MyMissle, isSpaceShipAnimation: false, spaceshipHasAnimation:true);
        self.Health = 1;
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for var count in 1...30{
            self._missles.append(Missle(missleAtlasName: GeneralGameSettings.MyMissle_Name, position: CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type: ActorType.MyMissle, speed: GeneralGameSettings.MyMissle_Speed, damage:1, timePerFrame: GeneralGameSettings.MyMissle_Frequency));
            self._missles.append(Missle(missleAtlasName: GeneralGameSettings.MyMissleC_Name, position: CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type: ActorType.MyMissleSpeed, speed: GeneralGameSettings.MyMissleC_Speed, damage:2, timePerFrame: GeneralGameSettings.MyMissleC_Frequency));
            
            if(count % 3 == 0){
                self._missles.append(Missle(missleAtlasName: GeneralGameSettings.MyMissleB_Name, position: CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type: ActorType.MyMissleTriple, speed: GeneralGameSettings.MyMissleB_Speed, damage:2, timePerFrame: GeneralGameSettings.MyMissleB_Frequency));
            }
            else if(count % 3 == 1){
                self._missles.append(Missle(missleAtlasName: GeneralGameSettings.MyMissleB_Name, position: CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type: ActorType.MyMissleTriple, speed: GeneralGameSettings.MyMissleB_Speed, damage:2, xspeed: 3, timePerFrame: GeneralGameSettings.MyMissleB_Frequency));
            }
            else{
                self._missles.append(Missle(missleAtlasName: GeneralGameSettings.MyMissleB_Name, position: CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type: ActorType.MyMissleTriple, speed: GeneralGameSettings.MyMissleB_Speed, damage:2, xspeed: -3, timePerFrame: GeneralGameSettings.MyMissleB_Frequency));
            }
        }
    }
    
    override func Explode() {
        self._missleTimer.ToggleMissleTimer(isOn: false, targetSpaceship: self, missleFz: GeneralGameSettings.MyMissle_Frequency);
        self._thruster.SetActive(false);
        self._tiltLeft.SetActive(false);
        self._tiltRight.SetActive(false);
        super.Explode();
    }
    
    override func Update(){
        self.movementUpdate();
        self.shieldUpdate(health:self.Health);
        self.positionUpdate();
        self.invincibleUpdate();
        
        super.Update();
    }
    
    override func SetActive(_ isActive:Bool){
        self._missleTimer.ToggleMissleTimer(isOn: isActive, targetSpaceship: self, missleFz: GeneralGameSettings.MyMissle_ShootingSpeed);
        self._thruster.SetActive(isActive);
        self._tiltLeft.SetActive(isActive);
        self._tiltRight.SetActive(isActive);
        self._shield.SetActive(isActive);
        self._shield1.SetActive(isActive);
        self._shield2.SetActive(isActive);
        self._shield2.RunAnimation {};
        self._shield1.RunAnimation {};
        self._shield.RunAnimation {};
        self._thruster.RunAnimation {};
        self._shield2.alpha = 0;
        self._shield1.alpha = 0;
        self._shield.alpha = 0;
        self._alpha = 0;
        self.Position = self._initialPosition;
        super.SetActive(isActive);
    }
    
    override func AddMissle() {
        super.AddMissle();
    }
    
    override func StopMissle(){
        super.StopMissle();
    }
    
    
    //Public Methods
    func Respawn(){
            _respawnTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.respawnTimerCallback), userInfo: nil, repeats: false);
    }
    
    func Invincible(seconds:Double)
    {
        _invincibleTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(self.invincibleTimerCallback), userInfo: nil, repeats: false);
    }
    
    func invincibleTimerCallback(){
        self._isInvincible = false;
    }
    
    func respawnTimerCallback(){
        if(UserStatsInfo.instance.Life.value > 0){
            self.SetActive(true);
            self.Invincible(seconds: 3);
            self._isInvincible = true;
        }
    }
    
    // Private Methods
    func SetMissleType(missleType: ActorType){
        self._missleTimer.ToggleMissleTimer(isOn: false, targetSpaceship: self, missleFz: 0);
        self._missleType = missleType;
        switch missleType {
        case .MyMissle:
            self._missleTimer.ToggleMissleTimer(isOn: true, targetSpaceship: self, missleFz: GeneralGameSettings.MyMissle_ShootingSpeed);
        case .MyMissleSpeed:
            self._missleTimer.ToggleMissleTimer(isOn: true, targetSpaceship: self, missleFz: GeneralGameSettings.MyMissleC_ShootingSpeed);
        case .MyMissleTriple:
            self._missleTimer.ToggleMissleTimer(isOn: true, targetSpaceship: self, missleFz: GeneralGameSettings.MyMissleB_ShootingSpeed);
        default:
            break;
          //  self._missleTimer.ToggleMissleTimer(isOn: true, targetSpaceship: self, missleFz: GeneralGameSettings.MyMissle_ShootingSpeed);
        }
    }
    
    fileprivate func movementUpdate(){
        if(GameConfiguration.instance.MoveMentType == .Classic){
            switch self._moveDirection{
            case .left:
                if(self.Spaceship.position.x  > (self.Spaceship.Width / 2))
                {
                    self.Spaceship.position.x -= self.Speed;
                }
                
                break;
            case .none, .inActive, .active:
                break;
            case .right:
                if(self.Spaceship.position.x   < (GameScene.instance!.frame.width - (self.Spaceship.Width / 2)))
                {
                    self.Spaceship.position.x  += self.Speed;
                }
            }
        }
        else{
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
            case .none, .inActive:
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
                break;
            default:
                break;
            }
        }
    }
    
    fileprivate func shieldUpdate(health:Int){
        if health == 4, self._shield2.alpha == CGFloat(0){
            self._shield2.alpha = 0.01;
            
            self._shield.FadeOut(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield1.FadeOut(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);

            self._shield2.FadeIn(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield2.RunAnimation {};
            
        }
        else if health  == 3, self._shield.alpha == CGFloat(0){
            self._shield.alpha = 0.01;
            
            self._shield2.FadeOut(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield1.FadeOut(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield.FadeIn(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield.RunAnimation {};
            
        }
        else if health == 2, self._shield1.alpha == CGFloat(0){
            self._shield1.alpha = 0.01;

            self._shield.FadeOut(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield2.FadeOut(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield1.FadeIn(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT);
            self._shield1.RunAnimation {};
        }
        else if health == 1, (self._shield1.alpha == CGFloat(1) || self._shield.alpha == CGFloat(1) || self._shield2.alpha == CGFloat(1)){
            self._shield2.alpha = 0;
            self._shield1.alpha = 0.99;
            self._shield.alpha = 0;
            
            self._shield1.FadeOut(customTime: GeneralGameSettings.ITEM_SHIELD_FADEINOUT );
        }

    }
    
    fileprivate func invincibleUpdate(){
        if(_isInvincible){
            if(self._alpha <= 0)
            {
                _invicibleDim = false;
            }
            
            if(self._alpha >= 1)
            {
                _invicibleDim = true;
            }
            self._alpha = _invicibleDim ? self._alpha - 0.15 : self._alpha + 0.15;
        }
        
        if(!self._tiltLeft.hasActions() && !self._tiltRight.hasActions()){
            self.Spaceship.alpha = self._isInvincible ? self._alpha : self.Spaceship.alpha;
            self._tiltLeft.alpha = self._isInvincible ? self._alpha : self._tiltLeft.alpha;
            self._tiltRight.alpha = self._isInvincible ? self._alpha : self._tiltRight.alpha;
        }
        else if(self._tiltLeft.hasActions()){
            self._tiltLeft.alpha = self._isInvincible ? self._alpha : self._tiltLeft.alpha;
            
        }
        else if(self._tiltRight.hasActions()){
            self._tiltRight.alpha = self._isInvincible ? self._alpha : self._tiltRight.alpha;
        }
        
        self._thruster.alpha = self._isInvincible ? self._alpha : self._thruster.alpha;
    }
    
    fileprivate func positionUpdate(){
        self._tiltLeft.SyncPositionWith(actor: self.Spaceship);
        self._tiltRight.SyncPositionWith(actor: self.Spaceship);
        self._shield2.SyncPositionWith(actor: self.Spaceship);
        self._shield1.SyncPositionWith(actor: self.Spaceship);
        self._shield.SyncPositionWith(actor: self.Spaceship);
        self._thruster.SyncPositionWith(actor: self.Spaceship, offsetX:0,offsetY:-25);
    }
    
}

enum MoveDirection:Int{
    case left = -1, none, right, active, inActive
}
