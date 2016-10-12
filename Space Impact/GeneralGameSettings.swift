//
//  GeneralGameSettings.swift
//  Space Impact
//
//  Created by Chieh on 2/28/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

struct GeneralGameSettings {
    static let SCREEN_HEIGHT: Int = 800;
    static let SCREEN_WIDTH:Int = 400;
    static let SCREEN_EDGE_PADDINGS: CGFloat = 5;
    
    static let TRANSITION_FADEIN :CGFloat = 1;
    static let TRANSITION_FADEOUT: CGFloat = 0.5;
    
    // Main Menu Settings
    static let TITLE_FONTSIZE: CGFloat = 45;
    static let TITLE_FONTFAMILY: String = "AvenirNext-UltraLight"
    
    static let BUTTON_FONTSIZE: CGFloat = 25;
    static let BUTTON_PADDINGS: CGFloat = 30;
    static let BUTTON_FONTFAMILY:String = "AvenirNext-Medium";
    
    
    // Game Screen Setting
    static let GAMESCREEN_NAME = "Game";
    static let GAMESCREEN_LABEL_FONTSIZE: CGFloat = 25;
    static let GAMESCREEN_LABEL_FONTFAMILY: String = "Copperplate"
    static let GAMESCREEN_LEVELLABEL_FONTSIZE: CGFloat = 35;
    static let GAMESCREEN_LEVELLABEL_FADEIN: CGFloat = 1;
    static let GAMESCREEN_LEVELLABEL_FADEOUT: CGFloat = 0.5;
    static let MYSPACESHIP_CATEGORY: UInt32 = 0;
    
    
    static let GAMESCREEN_ICON_LIFE:String = "life";
    static let GAMESCREEN_ICON_BOMB:String = "bomb";
    
    static let ENEMY_CATEGORY: UInt32 = 1;
    // My Spaceship
    
    static let MYSPACESHIP_NAME:String = "Spaceship";
    static let MYSPACESHIP_SPEED: CGFloat = 7;
    static let MYSPACESHIP_EXPLOSION: String = "explosionA";
    
    static let MyMissle_Name:String = "missle";
    static let MyMissle_Frequency:Double = 0.25;
    
    
    //ROLLING ROCK A
    static let ROLLINGROCKA_NAME:String = "rollingrockA";
    static let ROLLINGROCKA_SPEED:CGFloat = 5;
    static let ROLLINGROCKA_HEALTH:Int = 1;
    static let ROLLINGROCKA_EXPLOSION:String = "explosionA";
    static let ROLLINGROCKA_SPAWN: Double = 2;
    static let ROLLINGROCKA_POINT: Int = 300;
    
    //ROLLING ROCK B
    static let ROLLINGROCKB_NAME:String = "RollingRockB";
    static let ROLLINGROCKB_SPEED:CGFloat = 5;
    static let ROLLINGROCKB_HEALTH:Int = 1;
    static let ROLLINGROCKB_EXPLOSION:String = "explosionA";
    static let ROLLINGROCKB_SPAWN: Double = 2;
    static let ROLLINGROCKB_ACC: CGFloat = 0.02;
    static let ROLLINGROCKB_POINT: Int = 300;
    
}
