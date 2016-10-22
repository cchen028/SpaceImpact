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
    fileprivate var _planet:[Planet];
    
    var Stars:[Star]{get{return self._stars}}
    var GameScreen:SKNode?{get{return self._gameScreen}}
    var PlayerSpaceship:Spaceship?{get{return self._spaceShip}}
    var Planets:[Planet]{get{return self._planet}}
    
    private init(){
        self._planet = [Planet]();
        self._stars = [Star]();
        self._gameScreen = nil;
        let location = CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.minY + 30);
        _spaceShip = Spaceship(position: location);
    }
    
    func CreateGameScreen(gameScreen:SKNode){
        self._gameScreen = gameScreen;
    }
    
    func GetTwoDigitNumber(orderNumber:Int) -> String{
        var fileName:String = "";
        if orderNumber < 10 {
            fileName += ("0" + String(orderNumber));
        }
        else
        {
            fileName += String(orderNumber);
            
        }
        
        return fileName;
    }
    
        
    func GenerateRandomPosition() -> CGPoint{
        let randomX = generateRandomNumber(GeneralGameSettings.SCREEN_WIDTH);
        let randomY = generateRandomNumber(100) + GeneralGameSettings.SCREEN_HEIGHT;
        let position = CGPoint(x:randomX, y:randomY);
        return position;
    }
    
    func GetSpaceshipInitialPos() -> CGPoint{
        return CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.minY + 30);
    }
    
    func GetRandomNumber( endRange:Int) -> Int{
        return generateRandomNumber(endRange);
    }
    
    func GetRandomPercentage() -> CGFloat{
        return CGFloat(generateRandomNumber(5))/5;
    }
    
    fileprivate func generateRandomNumber(_ range:Int) -> Int{
        var randomX = Int(arc4random_uniform(UInt32(range)));
        randomX = max(1,randomX);
        return randomX;
    }
}

