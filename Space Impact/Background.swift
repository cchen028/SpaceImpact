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
    fileprivate var _stars:[Star];
    fileprivate var _planet:[Planet];
    
    var IsActive:Bool{get{return self._isActive}}
    var Name:String{get{return self._name}}
    
    init(gs:GameScene)
    {
        self._planet = [Planet]();
        self._stars = [Star]();        self._type = BackgroundStarAnimationType.default;
        self._name = "Background";
        self._isActive = false;
        InitializeStars();
    }
    
    func InitializeStars(){
        CreateStarsCollection(StarType.slow, num:10);
        CreateStarsCollection(StarType.medium, num:10);
        CreateStarsCollection(StarType.fast, num:10);
        CreatePlanetsCollection();
    }
    
    func InitializePlanets(){
        
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
    
    func CreatePlanetsCollection(){
        for i in 0...GeneralGameSettings.BACKGROUND_PLANET_TOTAL-1{
            let scale = GameObjectServices.instance.GetRandomPercentage();
            let planet = Planet(planetType:i, scale:scale);
            _planet.append(planet);
        }
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
        var hasActivePlanet:Bool = false;
        var totalPlanet:Int = 0;

        for star in self._stars{
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
        
        for planet in self._planet{
            if(planet.IsActive){
                planet.Update();
                totalPlanet = totalPlanet + 1;
            }
            
            if totalPlanet == 2{
                hasActivePlanet = true;
            }
        }
        
        if(!hasActivePlanet){
            let planetType = GameObjectServices.instance.GetRandomNumber(endRange: GeneralGameSettings.BACKGROUND_PLANET_TOTAL+1);
            self._planet[planetType-1].SetActive(true);
        }
    }
    
    func SetActive(_ isActive: Bool) {
        self._isActive = isActive;
    }
}


enum BackgroundStarAnimationType{
    case `default`, mainMenu
}
