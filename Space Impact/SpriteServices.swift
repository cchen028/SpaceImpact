//
//  SpriteServices.swift
//  Space Impact
//
//  Created by Chieh on 3/9/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

struct SpriteServices {
    static func Hide(sprite:SKNode, fadeOut:Bool = false)
    {
        
            sprite.alpha = 0;
      
    }
    
    static func FadeOut(sprite:SKNode)
    {
        let fadeOutAnimation = SKAction.fadeOutWithDuration(NSTimeInterval(GeneralGameSettings.TRANSITION_FADEOUT));
        
        sprite.runAction(fadeOutAnimation);
    }
    
    static func Show(sprite:SKNode, fadeIn:Bool = false){
            sprite.alpha = 1;
    }
    
    static func FadeIn(sprite:SKNode)
    {
        let fadeInAnimation = SKAction.fadeInWithDuration(NSTimeInterval(GeneralGameSettings.TRANSITION_FADEIN));
        
        sprite.runAction(fadeInAnimation);
    }
    
    static func GenerateRandomPosition() -> CGPoint{
        let randomX = GenerateRandomNumber(GeneralGameSettings.SCREEN_WIDTH);
        let position = CGPoint(x:randomX, y:GeneralGameSettings.SCREEN_HEIGHT);
        return position;
    }
    
    static func GenerateRandomNumber(range:Int) -> Int{
        let randomX = Int(arc4random_uniform(UInt32(range)) + 1);
        return randomX;
        
    }
}
