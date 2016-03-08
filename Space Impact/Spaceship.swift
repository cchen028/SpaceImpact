//
//  Spaceship.swift
//  Space Impact
//
//  Created by Chieh on 2/19/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class Spaceship: SpaceshipActor{
    
    private var _initialPosition:CGPoint;
    private var _gameScene:GameScene;
    private var _missles:[Missle];
    private var _moveDirection:MoveDirection;
    
    private var _frameCount:CGFloat;
    
    var Missles:[Missle]{get{return self._missles}};
    var Direction:MoveDirection{get{return self._moveDirection} set(val){self._moveDirection = val}}
    
    init(gs:GameScene, position:CGPoint)
    {
        self._gameScene = gs;
        self._initialPosition = position;
        self._missles = [Missle]();
        self._frameCount = 0;
        self._moveDirection = MoveDirection.None;
        super.init(type: ActorType.MySpaceship, position:position);

        self._gameScene.addActor(self);
       
        
    }
    
    func callForWait(){
        
        
    }
    
    func stepsAfterDelay(){
        //your code after delay takes place here...
    }
    
    public func AddMissle() {
        //for(var i = 0; i < 20; i++)
     //   {
        
        self._missles.append(Missle(gs:self._gameScene, position:CGPoint(x:self.Position.x, y:self.Position.y + (self.ActualHeight / 2))));
      //  }
    }
    
    override func Update(){
        self.myMissleUpdate();
        self.spaceshipMovementUpdate();
        
    }
    
    private func myMissleUpdate(){
        for missle in self._missles{
            
            missle.Update();
            if missle.Sprite.position.y > CGFloat(GeneralGameSettings.SCREEN_HEIGHT)
            {
                self._missles.removeFirst();
            }
            
        }
    }
    
    private func spaceshipMovementUpdate(){
        switch self._moveDirection{
        case .Left:
            if(self.Sprite.position.x  > (self.Width / 2))
            {
                self.Sprite.position.x -= self.Speed;
            }
                break;
        case .None:
            break;
        case .Right:
            if(self.Sprite.position.x  < (self._gameScene.frame.width - (self.Width / 2)))
            {
                self.Sprite.position.x  += self.Speed;
            }
        default:
            break;
        }
    }
}

enum MoveDirection:Int{
    case Left = -1, None, Right
}
