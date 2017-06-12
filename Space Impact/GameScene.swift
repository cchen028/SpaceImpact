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
        let sdfasdf = touch?.tapCount;
        
        
        mainScreen?.HandlesTouch(touch!, withEvent: event);
        
        let location = touch!.location(in: self);
        
        
        if(GameConfiguration.instance.MoveMentType == .Classic)
        {
            if location.x > self.frame.midX{
                gameScreen?.HandlesTouch(position: touch!.location(in: self),direction: MoveDirection.right , isTouched: true);
            }
            else
            {
                gameScreen?.HandlesTouch(position: touch!.location(in: self),direction: MoveDirection.left , isTouched: true);
            }
        }
        else if( GameConfiguration.instance.MoveMentType == .FreeDrag){
            gameScreen?.HandlesTouch(position: touch!.location(in: self),direction: MoveDirection.none , isTouched: false, multipleTouch: sdfasdf! > 1);
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first;
        let positionInScene = touch!.location(in: self)
        let previousPosition = touch!.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
        let direction = translation.x > 0 ? MoveDirection.right : MoveDirection.left;
        
        if(GameConfiguration.instance.MoveMentType == .FreeDrag)
        {
            gameScreen?.HandlesTouch(position: translation, direction: direction, isTouched: true);
        }
        
    }

    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent!) {
        super.touchesCancelled(touches, with: event);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
        let touch = touches.first;
        gameScreen?.HandlesTouch(position: touch!.location(in: self), direction: MoveDirection.none, isTouched: false, touch: touch, event:event);
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
            gameScreen?.Update(currentTime);
        }
       
        /* Called before each frame is rendered */
        
        
    }
}
