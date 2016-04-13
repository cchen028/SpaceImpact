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
    
    private var _initialPosition:CGPoint;
    private var _gameScene:GameScene;
    private var _moveDirection:MoveDirection;
    private var _frameCount:CGFloat;
    
    
    var Position:CGPoint{get{return self.Spaceship.position}}
    var IsActive:Bool{get{return _isActive}};
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    var Direction:MoveDirection{get{return self._moveDirection} set(val){self._moveDirection = val}}
    
    init(gs:GameScene, position:CGPoint)
    {
        self._gameScene = gs;
        self._initialPosition = position;
        self._frameCount = 0;
        self._moveDirection = MoveDirection.None;
        
        super.init(gs: gs, imageName: GeneralGameSettings.MYSPACESHIP_NAME, explosionName:GeneralGameSettings.MYSPACESHIP_EXPLOSION, health: 1, speed: GeneralGameSettings.MYSPACESHIP_SPEED, damage: 1, position: position, scale:0.5, type:ActorType.MySpaceship);
        
        
        self.InitializeMissles();
    }
    
    func InitializeMissles(){
        for i in 1...15{
            self._missles.append(Missle(gs:self._gameScene, position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2)), type:ActorType.MyMissle));
        }
    }
    
    func Explode() {
        self._explosion.RunAnimation();
    }

    
    func Update(objects:[IActor]?){
        self.spaceshipMovementUpdate();
        self.mySpaceshipUpdate(objects);
        self.myMissleUpdate(objects);
        
        
        super.Update();
        
    }
    
    func SetActive(isActive:Bool){
        if(self._isActive == isActive)
        {
            return;
        }
        else{
            self._isActive = isActive;
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
    
    private func mySpaceshipUpdate(objects:[IActor]?){
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
    
    private func myMissleUpdate(objects:[IActor]?){
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
            
            let spaceObjects = objects!;
            for object in spaceObjects{
                if(object.Sprite.Type == ActorType.EnemySpaceship)
                {
                    MissleCollideUpdate(object, missleIndex:mIndex);
                }
            }
        }
    }
    
    private func spaceshipMovementUpdate(){
        switch self._moveDirection{
        case .Left:
            if(self.Spaceship.position.x  > (self.Spaceship.Width / 2))
            {
                self.Spaceship.position.x -= self.Speed;
            }
                break;
        case .None:
            break;
        case .Right:
            if(self.Spaceship.position.x  < (self._gameScene.frame.width - (self.Spaceship.Width / 2)))
            {
                self.Spaceship.position.x  += self.Speed;
            }
        default:
            break;
        }
    }
    
    func SelfCollideUpdate(actor: IActor){
        let collided =  self.Spaceship.frame.intersects(actor.Sprite.frame);

        if(collided)
        {
            self.SetActive(false);
            actor.SetActive(false);
        }
    }
    
    
    func MissleCollideUpdate(actor: IActor, missleIndex:Int){
        let collided =  self._missles[missleIndex].Missle.frame.intersects(actor.Sprite.frame);

        if(collided)
        {
            self._missles[missleIndex].SetActive(false);
            
            actor.SetActive(false);
        }
    }
    

}

enum MoveDirection:Int{
    case Left = -1, None, Right
}
