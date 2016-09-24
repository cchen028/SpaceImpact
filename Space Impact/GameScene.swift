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
    //var test = SpaceImpact.sharedInstance;
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
        
       // self.addChild(myLabel)
        
        backgroundtheme = Background(gs: self);
        
        mainScreen = MainScreen(gs:self);
        gameScreen = GameScreen();
        
        transitService = TransitionService();
        transitService?.AddStage(backgroundtheme!);
        transitService?.AddStage(mainScreen!);
        transitService?.AddStage(gameScreen!);
        
        transitService?.TransitTo(mainScreen!);
        
        
       // gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "runTimedCode", userInfo: nil, repeats: true);
        
        
   //     self.addStage(backgroundtheme);
        //Circle = SKShapeNode(circleOfRadius: 10)
      //  Circle?.position = CGPointMake(200, 200)
    //    Circle?.name = "defaultCircle"
       // Circle?.strokeColor = SKColor.whiteColor()
       // Circle?.glowWidth = 10.0
       // Circle?.fillColor = SKColor.yellowColor()
       // Circle?.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // Circle?.physicsBody?.dynamic = true //.physicsBody?.dynamic = true
       // self.addChild(Circle!.Shape);
        //self.addChild(Circle2!.Shape);
        
        
        
        
      //  let location = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame)+20);
       // self.spaceship = Actor(sprite: SKSpriteNode(imageNamed:"Spaceship"),position: location,scale:0.1);
       // self.spaceship = Spaceship(position: location);
      //  self.addActor(self.spaceship);
    }
    
   // func runTimedCode(){
      //  self.addActor(self.spaceship);
   // }
    
    
    
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
//        if(gameScreen!.IsActive)
//        {
//            self.gameScreen?.MySpaceship.Direction = MoveDirection.None;
//        }
        
        for touch in touches {
            let location = touch.location(in: self)
            touched = true;
           // var action2:SKAction;
            if location.x > self.frame.midX{
             //   action2 = SKAction.moveByX(100, y: 0, duration: 1);
            
                touchdirection = 1;
            }
            else
            {
           //     action2 = SKAction.moveByX(-100, y: 0, duration: 1);
                touchdirection = -1;
            }
            
           // let spaceship = Actor(sprite: SKSpriteNode(imageNamed:"Spaceship"),position: location,scale:0.1);
            
             // spaceship.Position = location;
            //let sprite = SKSpriteNode(imageNamed:"Spaceship")
            // sprite.xScale = 0.5
            //sprite.yScale = 0.5
            //sprite.position = location
            
           // let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            //let action2 = SKAction.moveToY(300, duration: 2)
            
           // spaceship.Sprite.runAction(SKAction.repeatActionForever(action))
            //spaceship!.Sprite.runAction((action2))
            
           // self.addChild(spaceship!.Sprite)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent!) {
        super.touchesCancelled(touches, with: event);
        
        
//        if(gameScreen!.IsActive)
//        {
//            self.gameScreen?.MySpaceship.Direction = MoveDirection.None;
//        }
       // touched = false
      //   touchdirection = 0;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touch = touches.first;
        
        gameScreen?.HandlesTouch(touch!, withEvent: event, isTouched: false);
        
//        touched = false;
//         touchdirection = 0;
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
        
        
        
        
     //   if(touchdirection == 1){
     //       spaceship?.Sprite.position.x += 5;
     //   }
     //   else if(touchdirection == -1){
     //       spaceship?.Sprite.position.x -= 5;
     //   }
      //  else{
            
     //   }
        //
       
        /* Called before each frame is rendered */
        
        
    }
    
//    func addActor(node:Spaceship)
//    {
//        if let myspaceship = node as? Spaceship{
//            self.addChild(myspaceship.Sprite);
//            for missle in myspaceship.Missles{
//                if missle != nil
//                {
//                self.addChild(missle!.Sprite);
//                }
//            }
//        }
//    }
    
    
    
    
    func addSpaceship(_ node:SpaceshipActor?)
    {
        self.addChild(node!.Spaceship);
//        if let shapeNode = node as? ShapeActor{
//            self.addChild(shapeNode.Shape);
//        }
//        else if let spriteNode = node as? SpriteActor{
//            self.addChild(spriteNode.Sprite);
//        }
    }
    
    func addActor(_ node:IActor?)
    {
        if let shapeNode = node as? ShapeActor{
            self.addChild(shapeNode);
        }
        else if let spriteNode = node as? SpriteActor{
            self.addChild(spriteNode);
        }
    }
    
//    func addStage(node:IStage?)
//    {
//        if let background = node as? Background{
//            for star in background.Stars{
//                self.addActor(star);
//            }
//        }
//        
//    }
    
}
