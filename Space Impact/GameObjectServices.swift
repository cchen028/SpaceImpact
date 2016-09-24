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
   // fileprivate var _rollingRocksA:[IActor];
    fileprivate var _spaceShip:Spaceship?;
    
    var Stars:[Star]{get{return self._stars}}
    var GameScreen:SKNode?{get{return self._gameScreen}}
   // var RollingRock:[IActor]{get{return self._rollingRocksA}}
    var PlayerSpaceship:Spaceship?{get{return self._spaceShip}}
    
    private init(){
        self._stars = [Star]();
        self._gameScreen = nil;
      //  self._rollingRocksA = [IActor]();
        let location = CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.minY + 30);
        _spaceShip = Spaceship(position: location);
    }
    
    func CreateGameScreen(gameScreen:SKNode){
        self._gameScreen = gameScreen;
    }
    
    func CreateStarsCollection(_ type: StarType, num:Int){
       // var stars:[Star] = [Star]();
        for _ in 1...num{
            let randomX = Int(arc4random_uniform(400) + 1);
            let randomY = Int(arc4random_uniform(800) + 1);
            let tempStar = Star(type: type, position: CGPoint(x:randomX , y: randomY));
            GameScene.instance!.addChild(tempStar);
            _stars.append(tempStar);
        }
    }
    
    func CreateSpaceShip(){
        self._spaceShip = Spaceship(position:SpriteServices.GetSpaceshipInitialPos());
    }
    
//    func CreateRollingRockA(num:Int){
//        for _ in 1...num{
//            let tempRock = RollingRockA(position:SpriteServices.GenerateRandomPosition());
//            _rollingRocksA.append(tempRock);
//        }
//    }
}

