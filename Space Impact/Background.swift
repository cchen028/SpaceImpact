//
//  Background.swift
//  Space Impact
//
//  Created by Chieh on 2/23/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

open class Background:IStage {
    fileprivate var _name:String;
    
   // fileprivate var _stars:[Star];
   // fileprivate var _gameScene:GameScene;
    fileprivate var _isActive:Bool;
    fileprivate var _type:BackgroundStarAnimationType;
    
    
    var IsActive:Bool{get{return self._isActive}}
    var Name:String{get{return self._name}}
    
   // var Stars:[Star]{get{return self._stars} set(val){self._stars = val}}
    init(gs:GameScene)
    {
        self._type = BackgroundStarAnimationType.default;
        self._name = "Background";
      //  self._gameScene    = gs;
      //  self._stars = [Star]();
        self._isActive = false;
        InitializeStars();
        
    }
    
    func InitializeStars(){
        
        GameObjectServices.instance.CreateStarsCollection(StarType.slow, num:10);
        GameObjectServices.instance.CreateStarsCollection(StarType.medium, num:10);
        GameObjectServices.instance.CreateStarsCollection(StarType.fast, num:10);
        
     //   GenerateStars(StarType.slow, num:10);
     //   GenerateStars(StarType.medium, num:10);
     //   GenerateStars(StarType.fast, num:10);
        
    }
    
    func InitializePlanets(){
        
    }
    
//    func GenerateStars(_ type: StarType, num:Int){
//        for _ in 1...num{
//            let randomX = Int(arc4random_uniform(400) + 1);
//            let randomY = Int(arc4random_uniform(800) + 1);
//            let tempStar = Star(type: type, position: CGPoint(x:randomX , y: randomY));
//            self._gameScene.addChild(tempStar);
//            self._stars.append(tempStar);
//        }
//    }
    
    func Notify(_ targetStage:String){
        if(targetStage == "Main")
        {
            self._type = BackgroundStarAnimationType.mainMenu;
        }
        else
        {
           self._type = BackgroundStarAnimationType.default;
        }
    }
    
    open func Update(){
        for star in GameObjectServices.instance.Stars{
            star.Update();
            if(self._type == BackgroundStarAnimationType.mainMenu)
            {
                star.MainMenuSpecialEffect();
            }
            else
            {
                star.DefaultSpecialEffect();
            }
        }
    }
    
    func SetActive(_ isActive: Bool) {
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
    
    func Active(){
    
    }
    
    func InActive() {

    }
    
}


enum BackgroundStarAnimationType{
    case `default`, mainMenu
}
