//
//  TransitionService.swift
//  Space Impact
//
//  Created by Chieh on 2/28/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class TransitionService {
    private var _stages:[IStage];
    
    init() {
        self._stages = [IStage]();
    }
    
    func TransitTo(targetStage:IStage)
    {
        for var stage in self._stages{
            if stage.IsActive{
                stage.IsActive = false;
            }
            
            if(stage.Name == targetStage.Name)
            {
                stage.IsActive = true;
            }
            
            if(stage.Name == "Background")
            {
                stage.Notify(targetStage.Name);
            }
        }
    }
    
    func AddStage(stage:IStage)
    {
        self._stages.append(stage);
    }
    
    func GetActiveStage() -> IStage?{
        for var stage in self._stages{
            if stage.IsActive{
                return stage;
            }
        }
        return nil;
    }
    
    
}
