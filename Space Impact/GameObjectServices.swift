//
//  GameObjectServices.swift
//  Space Impact
//
//  Created by Chieh on 9/10/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

struct GameObjectServices {
    static func CreateStarsCollection(_ type: StarType, num:Int) -> [Star]{
        var stars:[Star] = [Star]();
        for _ in 1...num{
            let randomX = Int(arc4random_uniform(400) + 1);
            let randomY = Int(arc4random_uniform(800) + 1);
            let tempStar = Star(type: type, position: CGPoint(x:randomX , y: randomY));
            stars.append(tempStar);
        }
        
        return stars;
    }
    
}

