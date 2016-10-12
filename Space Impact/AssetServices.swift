//
//  AssetServices.swift
//  Space Impact
//
//  Created by Chieh on 3/11/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class AssetServices {
    fileprivate var _skTextures:[String:SKTexture];
    fileprivate var _skTexturesList:[String:[SKTexture]];
   
    var SKTextures:[String:SKTexture]{get{return self._skTextures}};
    var SKTexturesList:[String:[SKTexture]]{get{return self._skTexturesList}};
    
    init() {
        _skTextures = [String:SKTexture]();
        _skTextures["button"] = SKTexture(imageNamed: "button");
        _skTextures["missle"] = SKTexture(imageNamed: "missle");
        _skTextures["none"] = SKTexture(imageNamed: "none");
        _skTextures[GeneralGameSettings.MYSPACESHIP_NAME] = SKTexture(imageNamed: GeneralGameSettings.MYSPACESHIP_NAME);
        _skTextures[GeneralGameSettings.MyMissle_Name] = SKTexture(imageNamed: GeneralGameSettings.MyMissle_Name);
        _skTextures[GeneralGameSettings.GAMESCREEN_ICON_LIFE] = SKTexture(imageNamed: GeneralGameSettings.GAMESCREEN_ICON_LIFE);
        _skTextures[GeneralGameSettings.GAMESCREEN_ICON_BOMB] = SKTexture(imageNamed: GeneralGameSettings.GAMESCREEN_ICON_BOMB);

        _skTexturesList = [String:[SKTexture]]();
        
        self.InitializeAtlas(GeneralGameSettings.ROLLINGROCKA_NAME);
        self.InitializeAtlas(GeneralGameSettings.ROLLINGROCKB_NAME);
        self.InitializeAtlas(GeneralGameSettings.ROLLINGROCKA_EXPLOSION);
    }
    
    fileprivate func InitializeAtlas(_ atlasName:String){
        let _atlas = SKTextureAtlas(named:atlasName);
        let spriteTextName = self.getFileName(atlasName, orderNumber: 1);
        var spriteTextures = [SKTexture]();
        
        for i in (1..._atlas.textureNames.count){
            spriteTextures.append(_atlas.textureNamed(self.getFileName(atlasName, orderNumber: i)));
        }
        
        self._skTexturesList[atlasName] = spriteTextures;
        
        _skTextures[atlasName] = SKTexture(imageNamed: spriteTextName);
    }
    
    
    fileprivate func getFileName(_ name:String, orderNumber:Int) -> String{
        var fileName:String = name + "_";
        if orderNumber < 10 {
            fileName += ("0" + String(orderNumber));
        }
        else
        {
            fileName += String(orderNumber);
            
        }
        
        return fileName;
    }
    
}
