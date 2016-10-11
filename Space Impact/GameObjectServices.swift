//
//  GameObjectServices.swift
//  Space Impact
//
//  Created by Chieh on 9/10/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class GameObjectServices {
    static let instance = GameObjectServices();
    
    fileprivate var _stars:[Star];
    fileprivate var _gameScreen:SKNode?;
    fileprivate var _spaceShip:Spaceship?;
    
    var Stars:[Star]{get{return self._stars}}
    var GameScreen:SKNode?{get{return self._gameScreen}}
    var PlayerSpaceship:Spaceship?{get{return self._spaceShip}}
    
    private init(){
        self._stars = [Star]();
        self._gameScreen = nil;
        let location = CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.minY + 30);
        _spaceShip = Spaceship(position: location);
    }
    
    func CreateGameScreen(gameScreen:SKNode){
        self._gameScreen = gameScreen;
    }
    
    func CreateStarsCollection(_ type: StarType, num:Int){
        for _ in 1...num{
            let randomX = Int(arc4random_uniform(400) + 1);
            let randomY = Int(arc4random_uniform(800) + 1);
            let tempStar = Star(type: type, position: CGPoint(x:randomX , y: randomY));
            GameScene.instance!.addChild(tempStar);
            _stars.append(tempStar);
        }
    }
    
    func GenerateRandomPosition() -> CGPoint{
        let randomX = generateRandomNumber(GeneralGameSettings.SCREEN_WIDTH);
        let randomY = generateRandomNumber(GeneralGameSettings.SCREEN_HEIGHT)+800;
        let position = CGPoint(x:randomX, y:randomY);
        return position;
    }
    
    func GetSpaceshipInitialPos() -> CGPoint{
        return CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.minY + 30);
    }
    
    fileprivate func generateRandomNumber(_ range:Int) -> Int{
        let randomX = Int(arc4random_uniform(UInt32(range)) + 1);
        return randomX;
    }
}

