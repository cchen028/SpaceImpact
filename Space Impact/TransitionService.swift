//
//  TransitionService.swift
//  Space Impact
//
//  Created by Chieh on 2/28/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class TransitionService {
    fileprivate var _stages:[IStage];
    
    init() {
        self._stages = [IStage]();
    }
    
    func TransitTo(_ targetStage:IStage)
    {
        for stage in self._stages{
            if stage.IsActive{
                stage.SetActive(false);
            }
            
            if(stage.Name == targetStage.Name)
            {
                stage.SetActive(true);
            }
            
            if(stage.Name == "Background")
            {
                stage.Notify(targetStage.Name);
            }
        }
    }
    
    func AddStage(_ stage:IStage)
    {
        self._stages.append(stage);
    }
    
    func GetActiveStage() -> IStage?{
        for stage in self._stages{
            if stage.IsActive{
                return stage;
            }
        }
        return nil;
    }
    
    
}
