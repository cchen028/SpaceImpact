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
    static func Hide(_ sprite:SKNode, fadeOut:Bool = false)
    {
        
            sprite.alpha = 0;
      
    }
    
    static func FadeOut(_ sprite:SKNode)
    {
        let fadeOutAnimation = SKAction.fadeOut(withDuration: TimeInterval(GeneralGameSettings.TRANSITION_FADEOUT));
        
        sprite.run(fadeOutAnimation);
    }
    
    static func Show(_ sprite:SKNode, fadeIn:Bool = false){
            sprite.alpha = 1;
    }
    
    static func FadeIn(_ sprite:SKNode)
    {
        let fadeInAnimation = SKAction.fadeIn(withDuration: TimeInterval(GeneralGameSettings.TRANSITION_FADEIN));
        
        sprite.run(fadeInAnimation);
    }
    
    static func GenerateRandomPosition() -> CGPoint{
        let randomX = GenerateRandomNumber(GeneralGameSettings.SCREEN_WIDTH);
        let randomY = GenerateRandomNumber(GeneralGameSettings.SCREEN_HEIGHT)+800;
        let position = CGPoint(x:randomX, y:randomY);
        return position;
    }
    
    static func GenerateRandomNumber(_ range:Int) -> Int{
        let randomX = Int(arc4random_uniform(UInt32(range)) + 1);
        return randomX;
    }
}
