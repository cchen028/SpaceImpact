//
//  Level1.swift
//  Space Impact
//
//  Created by Chieh on 9/21/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation

class LevelClass {
    
    fileprivate var _enemies:[IActor];
    
    var Enemies:[IActor]{get{return self._enemies}}
    
    init(){
        self._enemies = [IActor]();
        
        self.CreateRollingRockA(num:25);
    }
    
    fileprivate func CreateRollingRockA(num:Int){
        for _ in 1...num{
            let tempRock = RollingRockA(position:SpriteServices.GenerateRandomPosition());
            self._enemies.append(tempRock);
        }
    }
    
}
