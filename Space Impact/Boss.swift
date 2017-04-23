//
//  Boss.swift
//  Space Impact
//
//  Created by Chieh on 4/2/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Boss: SpaceshipActor{
    
    fileprivate var _initialPosition:CGPoint;
    var Sprite:SpriteActor { get{return self.Spaceship}};
    
    fileprivate var _xSpeed:CGFloat;
    fileprivate var _ySpeed:CGFloat;
    fileprivate var _isWithingScreen:Bool;
    
    
    init(position:CGPoint)
    {
        self._initialPosition = position;
        self._xSpeed = GeneralGameSettings.BOSS_SPEED;
        self._ySpeed = GeneralGameSettings.BOSS_SPEED;
        self._isWithingScreen = false;
        super.init(imageName: GeneralGameSettings.BOSS_NAME, explosionName: GeneralGameSettings.BOSS_EXPLOSION, health: GeneralGameSettings.BOSS_HEALTH, speed: GeneralGameSettings.BOSS_SPEED, damage: 1, position: position, scale:1, type:ActorType.EnemySpaceship,  point: GeneralGameSettings.BOSS_POINT, isSpaceShipAnimation: false, spaceshipHasAnimation: false);
        
        self.CreateInjure(atlasName: GeneralGameSettings.INJUREA_NAME)
        self.InitializeMissles();
    }
    
    func InitializeMissles(){

        for _ in 1...4{
            self._missles.append(Missle(missleAtlasName: GeneralGameSettings.BOSS_MISSLE, position:CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y - (self.Spaceship.Height / 2)), type: ActorType.BlueBossMissle, speed: GeneralGameSettings.ENEMY_Speed));
        }
    }
    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            if(self.isWithinBoundary(position: self.Spaceship.position) && !self._isWithingScreen){
                self._isWithingScreen = true;
            }
            
            if(!self._isWithingScreen){
                self.Spaceship.position.y -= self._ySpeed;
            }
            
            else if(self.isWithinBoundary(position: self.Spaceship.position)){
                self.Spaceship.position.x -= self._xSpeed;
                self.Spaceship.position.y -= self._ySpeed;
            }
            else{
                self.Spaceship.position.x += self._xSpeed;
                self.Spaceship.position.y += self._ySpeed;
                
                self._xSpeed = CGFloat(GameObjectServices.instance.GetRandomPercentage() > 0.5 ? GameObjectServices.instance.GetRandomNumber(endRange: Int(self.Speed)):(GameObjectServices.instance.GetRandomNumber(endRange: Int(self.Speed)) * (-1)));
                self._ySpeed = CGFloat(GameObjectServices.instance.GetRandomPercentage() > 0.5 ? GameObjectServices.instance.GetRandomNumber(endRange: Int(self.Speed)):(GameObjectServices.instance.GetRandomNumber(endRange: Int(self.Speed)) * (-1)));
                
            }
        }
    }
    
    override func SetActive(_ isActive:Bool){
        self._missleTimer.ToggleMissleTimer(isOn: isActive, targetSpaceship: self, missleFz: GeneralGameSettings.BOSS_Missle_Frequency);

        super.SetActive(isActive);
        self._isWithingScreen = false;
    }
    
    override func Explode() {
        self._missleTimer.ToggleMissleTimer(isOn: false, targetSpaceship: self, missleFz: GeneralGameSettings.BOSS_Missle_Frequency);
        super.Explode();
    }
    
    fileprivate func isWithinBoundary(position: CGPoint) -> Bool{
        let bound = CGRect(x:0, y: Int(GameScene.instance!.frame.height - 300), width: GeneralGameSettings.SCREEN_WIDTH, height: 300);
        
        return bound.contains(position);
    }
}

