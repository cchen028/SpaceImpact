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
    private var _skTextures:[String:SKTexture];
    private var _skTexturesList:[String:[SKTexture]];
   // private var _spriteTextures: [SKTexture];
    

    
    var SKTextures:[String:SKTexture]{get{return self._skTextures}};
    
    
    var SKTexturesList:[String:[SKTexture]]{get{return self._skTexturesList}};
    
    init() {
        _skTextures = [String:SKTexture]();
        _skTextures["button"] = SKTexture(imageNamed: "button");
        _skTextures["missle"] = SKTexture(imageNamed: "missle");
        _skTextures["none"] = SKTexture(imageNamed: "none");
        _skTextures[GeneralGameSettings.MYSPACESHIP_NAME] = SKTexture(imageNamed: GeneralGameSettings.MYSPACESHIP_NAME);
        _skTextures[GeneralGameSettings.MyMissle_Name] = SKTexture(imageNamed: GeneralGameSettings.MyMissle_Name);
        
        _skTexturesList = [String:[SKTexture]]();
        
        
        self.InitializeAtlas(GeneralGameSettings.ROLLINGROCKA_NAME);
             self.InitializeAtlas(GeneralGameSettings.ROLLINGROCKA_EXPLOSION);
      //  InitializeAtlas(GeneralGameSettings.MYSPACESHIP_NAME);
        
        //InitializeAtlas(GeneralGameSettings.MyMissle_Name);
        
        //InitializeAtlas("rollingrockA");
        
       // _spriteTextures = [SKTexture]();
        
     //   super.init(texture: texture, color: UIColor.clearColor(), size: texture.size());
        
        
        
    }
    
    private func InitializeAtlas(atlasName:String){
        let _atlas = SKTextureAtlas(named:atlasName);
      //  let texture = SKTexture(imageNamed: atlasName + "_01");
        let spriteTextName = self.getFileName(atlasName, orderNumber: 1);
        var spriteTextures = [SKTexture]();
        
        for (var i = 1; i <= _atlas.textureNames.count; i++){
            spriteTextures.append(_atlas.textureNamed(self.getFileName(atlasName, orderNumber: i)));
        }
        
        self._skTexturesList[atlasName] = spriteTextures;
        
        _skTextures[atlasName] = SKTexture(imageNamed: spriteTextName);
    }
    
    
    private func getFileName(name:String, orderNumber:Int) -> String{
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