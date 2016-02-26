//
//  Background.swift
//  Space Impact
//
//  Created by Chieh on 2/23/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

public class Background:IStage {
    private var _stars:[Star];
    private var _gameScene:GameScene;
    
    var Stars:[Star]{get{return self._stars} set(val){self._stars = val}}
    init(gs:GameScene)
    {
        self._gameScene = gs;
        self._stars = [Star]();
        InitializeStars();
        
    }
    
    func InitializeStars(){
        GenerateStars(StarType.Slow, num:10);
        GenerateStars(StarType.Medium, num:10);
        GenerateStars(StarType.Fast, num:10);
        
    }
    
    func GenerateStars(type: StarType, num:Int){
        for index in 1...num{
            let randomX = Int(arc4random_uniform(400) + 1);
            let randomY = Int(arc4random_uniform(800) + 1);
            let tempStar = Star(type: type, position: CGPoint(x:randomX , y: randomY));
            self._gameScene.addChild(tempStar.Shape);
            self._stars.append(tempStar);
        }
    }
    
     public func Update(){
        for star in self._stars{
            star.Update();
        }
    }
    
}
