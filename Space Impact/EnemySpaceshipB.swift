//
//  EnemySpaceshipB.swift
//  Space Impact
//
//  Created by Chieh on 10/25/16.
//  Copyright © 2016 Jay. All rights reserved.
//

//
//  EnemySpaceshipA.swift
//  Space Impact
//
//  Created by Chieh on 3/6/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class EnemySpaceshipB: SpaceshipActor{
    
    
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    fileprivate var _animateLeft: SKAction;
    fileprivate var _animateRight:SKAction;
    internal var _moveLeft:SKAction?;
    internal var _moveRight:SKAction?;
    
    init(position:CGPoint)
    {
        let texture = (GameScene.instance?.AssetService?.SKTexturesList[GeneralGameSettings.ENEMYB_TILTLEFT_NAME])!;
        self._animateLeft = SKAction.animate(with: texture, timePerFrame: GeneralGameSettings.ENEMYB_MOVEMENT_TIMEPERFRAME);
        
        self._animateLeft = SKAction.repeat(self._animateLeft, count: 1);
        
        let texture2 = (GameScene.instance?.AssetService?.SKTexturesList[GeneralGameSettings.ENEMYB_TILTRIGHT_NAME])!;
        self._animateRight = SKAction.animate(with: texture2, timePerFrame: GeneralGameSettings.ENEMYB_MOVEMENT_TIMEPERFRAME);
        
        self._animateRight = SKAction.repeat(self._animateRight, count: 1);
        
        self._moveLeft = SKAction.moveBy(x: GeneralGameSettings.ENEMYB_MOVEBYX * CGFloat(-1), y: 3, duration: 2);
        self._moveRight = SKAction.moveBy(x: GeneralGameSettings.ENEMYB_MOVEBYX, y: 3, duration: 2);
        
        
        super.init(imageName: GeneralGameSettings.ENEMYB_NAME, explosionName: GeneralGameSettings.ENEMYB_EXPLOSION, health: GeneralGameSettings.ENEMYB_HEALTH, speed: GeneralGameSettings.ENEMYB_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship,  point: GeneralGameSettings.ENEMYB_POINT, isSpaceShipAnimation: false);
        self.initializeMovementAction();
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for _ in 1...25{
            self._missles.append(Missle(missleName: GeneralGameSettings.ENEMY_DEFAULTMISSLE_NAME, position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y - (self.Spaceship.Height / 2)), type: ActorType.EnemyMissle, speed: GeneralGameSettings.ENEMY_Speed));
        }
    }
    
    override func AddMissle() {
        super.AddMissle();
    }
    
    override func StopMissle(){
        super.StopMissle();
    }
    
    fileprivate func initializeMovementAction(){
        self._moveLeft = SKAction.sequence([self._animateRight.reversed(),self._animateLeft])
        self._moveLeft?.timingMode = SKActionTimingMode.easeInEaseOut;
        
        self._moveRight = SKAction.sequence([self._animateLeft.reversed(), self._animateRight]);
        self._moveRight?.timingMode = SKActionTimingMode.easeInEaseOut;
        
        self._movement = SKAction();
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
        
        let isFromLeft = self.Position.x <= 0;
        
        let bezierPath = isFromLeft ? UIBezierPath(arcCenter: CGPoint(x:0, y: 0), radius: self.Position.x + 250, startAngle:CGFloat(M_PI_2 * 3) , endAngle:CGFloat(0) , clockwise: true) : UIBezierPath(arcCenter: CGPoint(x:0, y: 0), radius: CGFloat(250) - (self.Position.x - CGFloat(GeneralGameSettings.SCREEN_WIDTH)), startAngle:CGFloat(M_PI_2 * 3) , endAngle:CGFloat(M_PI) , clockwise: false);
        let circularMove = SKAction.group([SKAction.follow(bezierPath.cgPath, asOffset: true, orientToPath: true, duration: 2), isFromLeft ? self._moveLeft! : self._moveRight!]);
        let rotateMove = SKAction.group([SKAction.rotate(toAngle: CGFloat(M_PI), duration: 1)]);
        let dropMove = SKAction.move(to: CGPoint(x:GameScene.instance!.frame.midX, y:-30), duration: 2);
        
        let combinationMovement = SKAction.sequence([circularMove,rotateMove, dropMove]);
        
        if(isActive){
            self.Sprite.run(combinationMovement);
        }
        else{
            self.Sprite.removeAllActions();
        }
    }
    
    
    
    override func Update(){
        super.Update();
    }
    
    override func Explode() {
        self._missleTimer.ToggleMissleTimer(isOn: false, targetSpaceship: self, missleFz: GeneralGameSettings.ENEMYB_Missle_Frequency);
        
        self.moveSpaceShip(isOn: false);
        super.Explode();
    }
    
    
    fileprivate func moveSpaceShip(isOn: Bool){
        
        if(isOn){
           // self.Spaceship.run(self._movement!, completion: {});
        }
        else{
            self.Spaceship.removeAllActions();
        }
        
        
    }
    
}


