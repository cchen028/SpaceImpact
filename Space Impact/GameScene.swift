//
//  GameScene.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright (c) 2016 Jay. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
  
    
    static let instance = GameScene(fileNamed:"GameScene");
    var spaceship:SpriteActor?;
    var touched:Bool?;
    var touchdirection:Int?;
    var backgroundtheme:Background?;
    var mainScreen:MainScreen?;
    var gameScreen:GameScreen?;
    var button:Button?;
    var gameTimer: Timer?;
    static let sharedInstance = self;
    
    fileprivate var _assetServices:AssetServices?;
    
    var AssetService:AssetServices?{ get{return self._assetServices}}
    
    var transitService:TransitionService?;
    
    override func didMove(to view: SKView) {
        
        /* Setup your scene here */

        touched = false;
        _assetServices = AssetServices();
        
        
        self.backgroundColor = SKColor.black;
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0);
        
        backgroundtheme = Background(gs: self);
        
        mainScreen = MainScreen();
        gameScreen = GameScreen();
        
        transitService = TransitionService();
        transitService?.AddStage(backgroundtheme!);
        transitService?.AddStage(mainScreen!);
        transitService?.AddStage(gameScreen!);
        
        transitService?.TransitTo(mainScreen!);
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
    
        if(touches.count<=0)
        {
            touched = false;
            touchdirection = 0;
            return;
        
        }
        
        let touch = touches.first;
        
        
        mainScreen?.HandlesTouch(touch!, withEvent: event);
        gameScreen?.HandlesTouch(touch!, withEvent: event, isTouched: true);
        
        for touch in touches {
            let location = touch.location(in: self)
            touched = true;
            if location.x > self.frame.midX{
                touchdirection = 1;
            }
            else
            {
                touchdirection = -1;
            }
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent!) {
        super.touchesCancelled(touches, with: event);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touch = touches.first;
        
        gameScreen?.HandlesTouch(touch!, withEvent: event, isTouched: false);
        
    }
    
    
   
    override func update(_ currentTime: TimeInterval) {
        
        backgroundtheme?.Update();
        
        
        
        if mainScreen!.IsStarted
        {
            mainScreen?.IsStarted = false;
            transitService?.TransitTo(gameScreen!);
        }
        
        
        if mainScreen!.IsActive{
            mainScreen?.Update();
        }
        
        
        if gameScreen!.IsActive {
            gameScreen?.Update();
        }
       
        /* Called before each frame is rendered */
        
        
    }
}
