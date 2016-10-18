//
//  EnemySpaceshipA.swift
//  Space Impact
//
//  Created by Chieh on 3/6/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class EnemySpaceshipA: SpaceshipActor{

    
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    fileprivate var _animateLeft: SKAction;
    fileprivate var _animateRight:SKAction;
    internal var _moveLeft:SKAction?;
    internal var _moveRight:SKAction?;
    
    init(position:CGPoint)
    {
        let texture = (GameScene.instance?.AssetService?.SKTexturesList[GeneralGameSettings.ENEMYA_TILTLEFT_NAME])!;
        self._animateLeft = SKAction.animate(with: texture, timePerFrame: GeneralGameSettings.ENEMY_MOVEMENT_TIMEPERFRAME);
        
        self._animateLeft = SKAction.repeat(self._animateLeft, count: 1);
        
        let texture2 = (GameScene.instance?.AssetService?.SKTexturesList[GeneralGameSettings.ENEMYA_TILTRIGHT_NAME])!;
        self._animateRight = SKAction.animate(with: texture2, timePerFrame: GeneralGameSettings.ENEMY_MOVEMENT_TIMEPERFRAME);
        
        self._animateRight = SKAction.repeat(self._animateRight, count: 1);
        
        self._moveLeft = SKAction.moveBy(x: GeneralGameSettings.ENEMYA_MOVEBYX * CGFloat(-1), y: 3, duration: 2);
        self._moveRight = SKAction.moveBy(x: GeneralGameSettings.ENEMYA_MOVEBYX, y: 3, duration: 2);

        
        super.init(imageName: GeneralGameSettings.ENEMYA_NAME, explosionName: GeneralGameSettings.ENEMYA_EXPLOSION, health: GeneralGameSettings.ENEMYA_HEALTH, speed: GeneralGameSettings.ENEMYA_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship,  point: GeneralGameSettings.ENEMYA_POINT, isSpaceShipAnimation: false);
        self.initializeMovementAction();
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for _ in 1...25{
            self._missles.append(Missle(missleName: GeneralGameSettings.ENEMY_DEFAULTMISSLE_NAME, position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y - (self.Spaceship.Height / 2)), type: ActorType.EnemyMissle));
        }
    }
    
    override func AddMissle() {
        super.AddMissle();
    }
    
    override func StopMissle(){
        super.StopMissle();
    }
    
    fileprivate func initializeMovementAction(){
        let tiltLeft = super.RunParelle(action1: SKAction.sequence([self._animateRight.reversed(),self._animateLeft]), action2: self._moveLeft!);
        tiltLeft.timingMode = SKActionTimingMode.easeInEaseOut;
        
        let tiltRight = super.RunParelle(action1: SKAction.sequence([self._animateLeft.reversed(), self._animateRight]), action2: self._moveRight!);
        tiltRight.timingMode = SKActionTimingMode.easeInEaseOut;

        
        self._movement = SKAction.sequence([tiltLeft,tiltRight]);
        self._movement = SKAction.repeatForever(self._movement!);
        
    }
    
    fileprivate func misslesUpdate(){
        if self._missles.count > 0{
            for mIndex in 0...(self._missles.count - 1){
                self._missles[mIndex].Update();
            }
        }
    }
    
    override func SetActive(_ isActive:Bool){
        self._missleTimer.ToggleMissleTimer(isOn: isActive, targetSpaceship: self, missleFz: GeneralGameSettings.ENEMYA_Missle_Frequency);
        self.moveSpaceShip(isOn: isActive);
        super.SetActive(isActive);
    }


    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self.Spaceship.position.y -= 2;
        }
    }
    
    override func Explode() {
        self.moveSpaceShip(isOn: false);
        super.Explode();
    }

    
    fileprivate func moveSpaceShip(isOn: Bool){
    
        if(isOn){
            self.Spaceship.run(self._movement!, completion: {});
        }
        else{
            self.Spaceship.removeAllActions();
        }
        
     
    }
    
}

