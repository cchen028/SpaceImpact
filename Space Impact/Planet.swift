//
//  Planet.swift
//  Space Impact
//
//  Created by Chieh on 10/12/16.
//  Copyright © 2016 Jay. All rights reserved.
//
import UIKit
import SpriteKit

class Planet: SpriteActor {
   
    
    fileprivate var _speed:CGFloat;
    
    var Speed:CGFloat{get{return self._speed}};
    
    init(planetType:Int)
    {
        
        self._speed = GeneralGameSettings.BACKGROUND_PLANET_SPEED;
        super.init(imageName: GeneralGameSettings.BACKGROUND_PLANET + GameObjectServices.instance.GetTwoDigitNumber(orderNumber: planetType), position: GameObjectServices.instance.GenerateRandomPosition(), scale: 1, opacity: 1, type:ActorType.None);
        super.zPosition = -1;
    }
    
    init(planetType:Int, scale:CGFloat)
    {
        self._speed = GeneralGameSettings.BACKGROUND_PLANET_SPEED + scale;
    super.init(imageName: GeneralGameSettings.BACKGROUND_PLANET + GameObjectServices.instance.GetTwoDigitNumber(orderNumber: planetType), position: GameObjectServices.instance.GenerateRandomPosition(), scale: scale, opacity: 1, type:ActorType.None);
    super.zPosition = -2 + self._speed ;
    }
    
    required init?(coder aDecoder: NSCoder) {
        self._speed = 1;
        super.init(coder: aDecoder);
    }
    
    func Update(){
        if self.position.y < GameScene.instance!.frame.minX - self.frame.height/2{
            self.SetActive(false);
            self.position = GameObjectServices.instance.GenerateRandomPosition();
        }
        else{
            self.position.y -= self._speed;
        }
    }
    
    override func SetActive(_ isActive: Bool) {
        super.SetActive(isActive);
    }
}

enum PlanetType{
    
}


