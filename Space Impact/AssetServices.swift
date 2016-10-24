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
        
        _skTexturesList = [String:[SKTexture]]();
        
        _skTextures = [String:SKTexture]();
        _skTextures["button"] = SKTexture(imageNamed: "button");
        _skTextures["missle"] = SKTexture(imageNamed: "missle");
        _skTextures["none"] = SKTexture(imageNamed: "none");
        _skTextures[GeneralGameSettings.MYSPACESHIP_NAME] = SKTexture(imageNamed: GeneralGameSettings.MYSPACESHIP_NAME);
        _skTextures[GeneralGameSettings.MYSPACESHIP_RIGHT_NAME] = SKTexture(imageNamed: GeneralGameSettings.MYSPACESHIP_RIGHT_NAME);
        _skTextures[GeneralGameSettings.MYSPACESHIP_LEFT_NAME] = SKTexture(imageNamed: GeneralGameSettings.MYSPACESHIP_LEFT_NAME);
        _skTextures[GeneralGameSettings.MyMissle_Name] = SKTexture(imageNamed: GeneralGameSettings.MyMissle_Name);
        _skTextures[GeneralGameSettings.GAMESCREEN_ICON_LIFE] = SKTexture(imageNamed: GeneralGameSettings.GAMESCREEN_ICON_LIFE);
        _skTextures[GeneralGameSettings.GAMESCREEN_ICON_BOMB] = SKTexture(imageNamed: GeneralGameSettings.GAMESCREEN_ICON_BOMB);
        
        _skTextures[GeneralGameSettings.ENEMYA_NAME] = SKTexture(imageNamed: GeneralGameSettings.ENEMYA_NAME);
        
        _skTextures[GeneralGameSettings.MYSPACESHIP_THRUSTER_NAME] = SKTexture(imageNamed: GeneralGameSettings.MYSPACESHIP_THRUSTER_NAME);
        _skTextures[GeneralGameSettings.ENEMY_DEFAULTMISSLE_NAME] = SKTexture(imageNamed: GeneralGameSettings.ENEMY_DEFAULTMISSLE_NAME);
        
        
        for i in (0...GeneralGameSettings.BACKGROUND_PLANET_TOTAL){
            let tempPlanetName = self.getFileName(GeneralGameSettings.BACKGROUND_PLANET, orderNumber: i, split: "");
            _skTextures[tempPlanetName] = SKTexture(imageNamed: tempPlanetName);
        }

        
        self.InitializeAtlas(GeneralGameSettings.ROLLINGROCKA_NAME);
        self.InitializeAtlas(GeneralGameSettings.ROLLINGROCKB_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ROLLINGROCKA_EXPLOSION);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.MYSPACESHIP_TILTLEFT_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.MYSPACESHIP_TILTRIGHT_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ENEMYA_TILTLEFT_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ENEMYA_TILTRIGHT_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ENEMYA_EXPLOSION);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.MYSPACESHIP_SHIEDA_NAME);
        
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.MYSPACESHIP_SHIEDB_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.MYSPACESHIP_SHIEDB_02_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.MYSPACESHIP_SHIEDB_01_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ITEM_SHIELD_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ITEM_CAPTUREA_NAME);
        
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ITEM_CAPTUREB_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ITEM_CAPTUREC_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.EXPLOSIONC_NAME);
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ITEM_LIGHTNING_NAME);
        
        self.InitializeAtlas_ZeroBase(GeneralGameSettings.ITEM_HEART_NAME);
        
        //ITEM_HEART_NAME
        
        
        
        
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
    
    fileprivate func InitializeAtlas_ZeroBase(_ atlasName:String){
        let _atlas = SKTextureAtlas(named:atlasName);
        let spriteTextName = self.getFileName(atlasName, orderNumber: 0, split: "");
        var spriteTextures = [SKTexture]();
        
        for i in (0..._atlas.textureNames.count-1){
            spriteTextures.append(_atlas.textureNamed(self.getFileName(atlasName, orderNumber: i, split: "")));
        }
        
        self._skTexturesList[atlasName] = spriteTextures;
        
        _skTextures[atlasName] = SKTexture(imageNamed: spriteTextName);
    }
    
    
    fileprivate func getFileName(_ name:String, orderNumber:Int, split:String = "_") -> String{
        var fileName:String = name + split;
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
