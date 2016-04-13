//
//  Background.swift
//  Space Impact
//
//  Created by Chieh on 2/23/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

public class Background:IStage {
    private var _name:String;
    
    private var _stars:[Star];
    private var _gameScene:GameScene;
    private var _isActive:Bool;
    private var _type:BackgroundStarAnimationType;
    
    
    var IsActive:Bool{get{return self._isActive}}
    var Name:String{get{return self._name}}
    
    var Stars:[Star]{get{return self._stars} set(val){self._stars = val}}
    init(gs:GameScene)
    {
        self._type = BackgroundStarAnimationType.Default;
        self._name = "Background";
        self._gameScene = gs;
        self._stars = [Star]();
        self._isActive = false;
        InitializeStars();
        
    }
    
    func InitializeStars(){
        GenerateStars(StarType.Slow, num:10);
        GenerateStars(StarType.Medium, num:10);
        GenerateStars(StarType.Fast, num:10);
        
    }
    
    func InitializePlanets(){
        
    }
    
    func GenerateStars(type: StarType, num:Int){
        for index in 1...num{
            let randomX = Int(arc4random_uniform(400) + 1);
            let randomY = Int(arc4random_uniform(800) + 1);
            let tempStar = Star(type: type, position: CGPoint(x:randomX , y: randomY));
            self._gameScene.addChild(tempStar);
            self._stars.append(tempStar);
        }
    }
    
    func Notify(targetStage:String){
        if(targetStage == "Main")
        {
            self._type = BackgroundStarAnimationType.MainMenu;
        }
        else
        {
           self._type = BackgroundStarAnimationType.Default;
        }
    }
    
    public func Update(){
        for star in self._stars{
            star.Update();
            if(self._type == BackgroundStarAnimationType.MainMenu)
            {
                star.MainMenuSpecialEffect();
            }
            else
            {
                star.DefaultSpecialEffect();
            }
        }
    }
    
    func SetActive(isActive: Bool) {
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
    case Default, MainMenu
}
