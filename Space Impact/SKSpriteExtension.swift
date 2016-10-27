//
//  SKSpriteExtension.swift
//  Space Impact
//
//  Created by Chieh on 10/26/16.
//  Copyright © 2016 Jay. All rights reserved.
//


import UIKit
import SpriteKit

extension SKAction {
    public class func rotateVersus(destPoint: CGPoint, position:CGPoint, durationRotation: TimeInterval, durationMove: TimeInterval)-> SKAction
    {
        let v1 = CGVector(dx:0, dy:1)
        let v2 = CGVector(dx:destPoint.x - position.x, dy: destPoint.y - position.y)
        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        
        let rotate = SKAction.rotate(byAngle: angle, duration: durationRotation)
        let move = SKAction.move(by: CGVector(dx: v2.dx * 0.9, dy: v2.dy * 0.9), duration: durationMove);
        move.timingMode = SKActionTimingMode.easeIn;
        let sequence = SKAction.sequence([rotate, move])
        
        return sequence;
    }
    
    
//    func rotateVersusss(destPoint: CGPoint, position:CGPoint, durationRotation: TimeInterval, durationMove: TimeInterval) -> SKAction{
//        let v1 = CGVector(dx:0, dy:1)
//        let v2 = CGVector(dx:destPoint.x - position.x, dy: destPoint.y - position.y)
//        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
//        
//        let rotate = SKAction.rotate(byAngle: angle, duration: durationRotation)
//        let move = SKAction.move(by: CGVector(dx: v2.dx * 0.9, dy: v2.dy * 0.9), duration: durationMove);
//     
//        let sequence = SKAction.sequence([rotate, move])
//        
//        return sequence;
//       // self.run(sequence);
//    }
}
