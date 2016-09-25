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
    fileprivate var _isActive:Bool;
    fileprivate var _type:BackgroundStarAnimationType;
    
    var IsActive:Bool{get{return self._isActive}}
    var Name:String{get{return self._name}}
    
    init(gs:GameScene)
    {
        self._type = BackgroundStarAnimationType.default;
        self._name = "Background";
        self._isActive = false;
        InitializeStars();
    }
    
    func InitializeStars(){
        
        GameObjectServices.instance.CreateStarsCollection(StarType.slow, num:10);
        GameObjectServices.instance.CreateStarsCollection(StarType.medium, num:10);
        GameObjectServices.instance.CreateStarsCollection(StarType.fast, num:10);
    }
    
    func InitializePlanets(){
        
    }
    
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
        self._isActive = isActive;
    }
}


enum BackgroundStarAnimationType{
    case `default`, mainMenu
}
