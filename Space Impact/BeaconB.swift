//
//  BeaconB.swift
//  Space Impact
//
//  Created by Chieh on 5/27/17.
//  Copyright © 2017 Jay. All rights reserved.
//


import UIKit
import SpriteKit

class BeaconB: SpaceshipActor{
    let events = EventManager();
    fileprivate var _initialPosition:CGPoint;
    var Sprite:SpriteActor { get{return self.Spaceship}}
    
    init(position:CGPoint)
    {
        self._initialPosition = position;
        
        super.init(imageName: GeneralGameSettings.BEACONB_NAME, explosionName: GeneralGameSettings.BEACONB_EXPLOSION, health: GeneralGameSettings.BEACONB_HEALTH, speed: GeneralGameSettings.BEACONB_SPEED, damage: 1, position: position, scale:1, type:ActorType.Beacon,  point: GeneralGameSettings.BEACONB_POINT, missleType: ActorType.None, isSpaceShipAnimation: false, spaceshipHasAnimation: false);
        self.CreateInjure(atlasName: GeneralGameSettings.INJUREB_NAME);
    }
    
    override func Update(){
        super.Update();
        if(self.IsActive)
        {
            self.Spaceship.position.y -= self.Speed;
        }
    }
    
    func GiveItem() {
        self.events.trigger(eventName: "GiveItem", information: self.Position);
    }
}

