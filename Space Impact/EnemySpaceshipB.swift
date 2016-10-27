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
//        let tiltLeft = super.RunParelle(action1: SKAction.sequence([self._animateRight.reversed(),self._animateLeft]), action2: self._moveLeft!);
//        tiltLeft.timingMode = SKActionTimingMode.easeInEaseOut;
//        
//        let tiltRight = super.RunParelle(action1: SKAction.sequence([self._animateLeft.reversed(), self._animateRight]), action2: self._moveRight!);
//        tiltRight.timingMode = SKActionTimingMode.easeInEaseOut;
        
        self._moveLeft = SKAction.sequence([self._animateRight.reversed(),self._animateLeft])
       // self._moveLeft = SKAction.repeatForever(self._moveLeft!);
        self._moveLeft?.timingMode = SKActionTimingMode.easeInEaseOut;
      //  self._moveLeft = SKAction.repeatForever(self._moveLeft!);
        
        self._moveRight = SKAction.sequence([self._animateLeft.reversed(), self._animateRight]);
        self._moveRight?.timingMode = SKActionTimingMode.easeInEaseOut;
        
        
        //self._movement = SKAction.sequence([tiltLeft,tiltRight]);
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
    
        //var circle = SKShapeNode.init(circleOfRadius: 200);
        
       // let circularMove = SKAction.follow(circle.path!, asOffset: false, orientToPath: true, duration: 5)
       // let bezierPath = UIBezierPath(arcCenter: CGPoint(x:GameScene.instance!.frame.midX, y: GameScene.instance!.frame.maxY - 100), radius: 100, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI_4), clockwise: true);
        
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x:0, y: GameScene.instance!.frame.midY * 1.7), radius: 200, startAngle:CGFloat(M_PI_2) , endAngle:CGFloat(0) , clockwise: true);
        
      //  let bPath = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 20, height: 30));
        
        let circularMove = SKAction.group([SKAction.follow(bezierPath.cgPath, asOffset: false, orientToPath: true, duration: 2), self._moveLeft!]);
      //  let rectMove = SKAction.follow(bPath.cgPath, asOffset: true, orientToPath: true, duration: 2)
        
        
       // let dropMove = SKAction.move(to: CGPoint(x: GameScene.instance!.frame.midX, y: -30 ), duration: 2);
        let dropMove = SKAction.group([SKAction.rotateVersus(destPoint: CGPoint(x: GameScene.instance!.frame.midX, y: GameScene.instance!.frame.minY ), position: self.Position, durationRotation: 0.5, durationMove: 2), self._moveLeft!]);
        //dropMove.timingMode = SKActionTimingMode.easeIn;
        
        //let dropMove2 = SKAction.rotateVersus(destPoint: CGPoint(x: GameScene.instance!.frame.midX, y: -30 ), position: self.Position, durationRotation: 1, durationMove: 5);
        
        
        let combinationMovement = SKAction.sequence([circularMove, dropMove]);
        
        if(isActive){
            self.Sprite.run(combinationMovement);
        }
        else{
            self.Sprite.removeAllActions();
        }
    }
    
    
    
    override func Update(){
        super.Update();
//        if(self.IsActive)
//        {
//            self.Spaceship.position.y -= 2;
//        }
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


