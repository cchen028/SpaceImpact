//
//  SpaceshipActor.swift
//  Space Impact
//
//  Created by Chieh on 3/5/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class SpaceshipActor: NSObject, ISpaceship{
    
    fileprivate var _health:Int;
    fileprivate var _initialHealth:Int;
    fileprivate var _speed:CGFloat;
    fileprivate var _damage:Int;
    fileprivate var _spaceship:SpriteActor;
    internal var _spaceship_left:SpriteActor?;
    internal var _spaceship_right:SpriteActor?;
    fileprivate var _spaceshipMissleTimer: Timer!;
    fileprivate var _point:Int;
    internal var _movement:SKAction?;
    internal var _missleType:ActorType;
    
    internal var _missleTimer:MissleTimer;
    internal var _explosion:SpriteActor;
    internal var _injured:SpriteActor?;
    internal var _missles:[Missle];
    
    var Health:Int{get{return _health} set(newVal){_health = newVal}};
    var Speed:CGFloat{get{return _speed} set(newVal){_speed = newVal}};
    var Damage:Int{get{return _damage} set(newVal){_damage = newVal}};
    var Explosion:SpriteActor{get{return _explosion} set(newVal){_explosion = newVal}};
    var Injured:SpriteActor?{get{return _injured} set(newVal){_injured = newVal}};
    var IsActive:Bool{get{return self._spaceship.IsActive && (self._explosion.IsActive || self._explosion.hasActions())}};
    //var IsActive:Bool{get{return self._spaceship.alpha > 0 || (self._explosion.alpha > 0)}};
    var Spaceship:SpriteActor{get{return self._spaceship}};
    var Missles:[Missle]{get{return self._missles}};
    var `Type`:ActorType{get{return self._spaceship.Type}};
    var Position:CGPoint{get{return self._spaceship.position} set(newVal){self._spaceship.position = newVal}}
    var Point:Int {get{return self._point}}
    var Target:Spaceship?;
    var MyMissleType:ActorType{get{return self._missleType}}

    init(imageName:String, explosionName: String, health:Int, speed:CGFloat, damage:Int , position:CGPoint,scale:CGFloat = 1,type:ActorType, point:Int = 0,missleType:ActorType = ActorType.None , isSpaceShipAnimation:Bool = false, spaceshipHasAnimation:Bool = false)
    {
        self._missleTimer = MissleTimer();
        self._missles = [Missle]();
        self._injured = nil;
        self._missleType = missleType;
        _health = health;
        _initialHealth = health;
        _speed = speed;
        _damage = damage;
        _point = point;
        
        
        _explosion = SpriteActor(atlasName:explosionName, position: position, scale: 1, opacity: 0, type:ActorType.Explosion, repeatCount: 1, startAnimating: false);
        
        
        
        
        
        if(spaceshipHasAnimation)
        {
            _spaceship_left = SpriteActor(imageName: imageName+"_left", position: position, scale: scale, opacity: 0, type:type);
            _spaceship_right = SpriteActor(imageName: imageName+"_right", position: position, scale: scale, opacity: 0, type:type);
            
            
            _spaceship_right!.zPosition = 8;
            _spaceship_left!.zPosition = 8;
        }
        
        if(isSpaceShipAnimation){
            _spaceship = SpriteActor(atlasName: imageName, position: position, scale: 1, opacity: 1, type:type, startAnimating: true);
        }
        else
        {
            _spaceship = SpriteActor(imageName: imageName, position: position, scale: scale, opacity: 1, type:type);
        }
        
        self._explosion.zPosition = 5;
        self._injured?.zPosition = 6;
        self._spaceship.zPosition = 5;
                
        super.init();
    }
    
    func RunParelle(action1: SKAction, action2: SKAction) -> SKAction{
        var longAction:SKAction = SKAction();
        var shortAction:SKAction = SKAction();
        
        if(action1.duration >= action2.duration){
            longAction = action1;
            shortAction = action2;
        }
        else{
            longAction = action2;
            shortAction = action1;
        }
        
        let difference = longAction.duration - shortAction.duration;
        let shortWithWait = SKAction.sequence([shortAction, SKAction.wait(forDuration: difference)]);
        let group = SKAction.group([longAction, shortWithWait])
        
        return group;
    }
    
    func CreateInjure(atlasName:String){
        self._injured = SpriteActor(atlasName:atlasName, position: self.Position, scale: 1, opacity: 0, type:ActorType.Injured, timePerFrame:0.05, repeatCount: 1, startAnimating: false);
        self._injured?.zPosition = 19;
    }
    
    func SetActive(_ isActive:Bool){
        if(isActive){
            self.create();
        }
        else{
            self.destroy();
        }
    }
    
    func Update(){
        if(self._spaceship.position.y < GameScene.instance!.frame.minY){
            self.SetActive(false);
        }
        
        self.misslesUpdate();
        self._explosion.SyncPositionWith(actor: self._spaceship);
        self._spaceship_left?.SyncPositionWith(actor: self._spaceship);
        self._spaceship_right?.SyncPositionWith(actor: self._spaceship);
    }
    
    func Injure(position:CGPoint){
        self._injured?.alpha = 1;
        self._injured?.position = position;
        self._injured?.RunAnimation(animationComplete: {
            self._injured?.removeAllActions();
            self._injured?.alpha = 0;
        });
    }
    
    func Explode(){
        self._explosion.alpha = 1;
        self._explosion.RunAnimation(animationComplete: {
            self._explosion.removeAllActions();
        });
        self._spaceship.SetActive(false);
        
    }
    
    func AddMissle() {
        if(_missles.count > 0){
            var count = 0;
            for i in 0...(_missles.count - 1){
                if(!_missles[i].IsActive && self._missleType == _missles[i].Sprite.Type){
                    count = count + 1;
                    switch _missles[i].Sprite.Type {
                    case .MyMissle:
                        _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2));
                        _missles[i].SetActive(true);
                    case .MyMissleSpeed:
                        _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2));
                        _missles[i].SetActive(true);
                    case .MyMissleTriple:
                        _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2));
                        _missles[i].SetActive(true);
                        if(count <= 3){
                            continue;
                        }
                    case .EnemyMissle:
                        _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y - (self.Spaceship.Height / 2));
                        _missles[i].SetActive(true);
                    case .BlueBossMissle:
                        _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y - (self.Spaceship.Height / 2));
                        _missles[i]._misEndPosition = (self.Target?.Position)!;
                        _missles[i].SetActive(true);
                    default:
                        _missles[i].Missle.position = CGPoint(x:self.Spaceship.position.x, y:self.Spaceship.position.y + (self.Spaceship.Height / 2));
                        _missles[i].SetActive(true);
                    }
                    break;
                }
            }
        }
    }
    
    func StopMissle(){
        if(_missles.count > 0){
            for i in 0...(_missles.count - 1){
                if(_missles[i].IsActive){
                    _missles[i].SetActive(false);
                }
            }
        }
    }
    
    open func moveLeft(){
        
    }
    
    
    
    func IsCollidedWith<T>(_ actor: T) -> Bool{
        
        if let spaceShipActor = actor as? SpaceshipActor{
            let pct = CGFloat(0.8);
            let mySPFrame = GameObjectServices.instance.GetAdjustedSpriteFrame(frame: self._spaceship.frame, scaleX: 0.9, scaleY: 0.8);
            let spFrame = GameObjectServices.instance.GetAdjustedSpriteFrame(frame: spaceShipActor._spaceship.frame, scaleX: 0.9, scaleY: 0.8);
            //  let mySPFrame = self._spaceship.frame.offsetBy(dx: self._spaceship.Width * -0.5, dy: self._spaceship.Height * -0.5);
           // let spFrame = spaceShipActor._spaceship.frame.offsetBy(dx: spaceShipActor._spaceship.Width * -0.5, dy: spaceShipActor._spaceship.Height * -0.5);
            //let circlePath = UIBezierPath(ovalInRect: CGRectInset(mySPFrame, 0.5, 0.5 ));
           // spFrame.
           // return spaceShipActor.Spaceship.IsActive && self._spaceship.IsActive && self._spaceship.frame.intersects(spaceShipActor.Spaceship.frame);
            return spaceShipActor.Spaceship.IsActive && self._spaceship.IsActive && mySPFrame.intersects(spFrame);
        }
        
        if let itemActor = actor as? ItemActor{
            return itemActor.Item.IsActive && self._spaceship.IsActive && self._spaceship.frame.intersects(itemActor.Item.frame);
        }
        
        return false;
    }
    
    fileprivate func misslesUpdate(){
        if self._missles.count > 0{
            for mIndex in 0...(self._missles.count - 1){
                self._missles[mIndex].Update();
            }
        }
    }
    
    fileprivate func create(){
        self._health = self._initialHealth;
        self._spaceship.SetActive(true);
        self._spaceship_left?.SetActive(true);
        self._spaceship_right?.SetActive(true);
        self._explosion.SetActive(true);
        self._injured?.SetActive(true);
    }
    
    fileprivate func destroy(){
        self._spaceship.SetActive(false);
        self._spaceship_left?.SetActive(false);
        self._spaceship_right?.SetActive(false);
        self._explosion.SetActive(false);
        self._injured?.SetActive(false);
        self._explosion.removeAllActions();
        self._injured?.removeAllActions();

    }
}
