//
//  GameScene.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright (c) 2016 Jay. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var spaceship:SpriteActor?;
    var touched:Bool?;
    var touchdirection:Int?;
    var backgroundtheme:Background?;
    var button:Button?;
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Jays Spaceship!!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        touched = false;
        
        
        self.button = Button(gs: self, displayText: "Start", position: CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)));
        self.backgroundColor = SKColor.blackColor();
        
       // self.addChild(myLabel)
        
        backgroundtheme = Background(gs: self);
        
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
        
        
        
        
        //let location = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame)+20);
       // self.spaceship = Actor(sprite: SKSpriteNode(imageNamed:"Spaceship"),position: location,scale:0.1);
        self.spaceship = Spaceship(type: ActorType.MySpaceship);
        self.addActor(self.spaceship);
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    
        if(touches.count<0)
        {
            touched = false;
            touchdirection = 0;
        
        }
        
        
        for touch in touches {
            let location = touch.locationInNode(self)
            touched = true;
           // var action2:SKAction;
            if location.x > CGRectGetMidX(self.frame){
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
    
    override func touchesCancelled(touches: Set<UITouch>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
        touched = false
         touchdirection = 0;
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        touched = false;
         touchdirection = 0;
    }
    
    
   
    override func update(currentTime: CFTimeInterval) {
        
        backgroundtheme?.Update();
        
        if(touchdirection == 1){
            spaceship?.Sprite.position.x += 5;
        }
        else if(touchdirection == -1){
            spaceship?.Sprite.position.x -= 5;
        }
        else{
            
        }
        //
       
        /* Called before each frame is rendered */
        
        
    }
    
    func addActor(node:IActor?)
    {
        if let star = node as? Star{
            self.addChild(star.Shape);
        }
        else if let button = node as? Button{
            self.addChild(button.Shape);
            self.addChild(button.Label);
        }
        else if let sprite = node as? SpriteActor{
            self.addChild(sprite.Sprite);
        }
    }
    
    func addStage(node:IStage?)
    {
        if let background = node as? Background{
            for star in background.Stars{
                self.addActor(star);
            }
        }
        
    }
    
}
