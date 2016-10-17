//
//  GeneralGameSettings.swift
//  Space Impact
//
//  Created by Chieh on 2/28/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

struct GeneralGameSettings {
    static let SCREEN_HEIGHT: Int = Int(GameScene.instance!.frame.height) + 100;
    static let SCREEN_WIDTH:Int = Int(GameScene.instance!.frame.width);
    static let SCREEN_EDGE_PADDINGS: CGFloat = 5;
    
    static let TRANSITION_FADEIN :CGFloat = 1;
    static let TRANSITION_FADEOUT: CGFloat = 0.5;
    
    // Main Menu Settings
    static let TITLE_FONTSIZE: CGFloat = 45;
    static let TITLE_FONTFAMILY: String = "AvenirNext-UltraLight"
    
    static let BUTTON_FONTSIZE: CGFloat = 25;
    static let BUTTON_PADDINGS: CGFloat = 30;
    static let BUTTON_FONTFAMILY:String = "AvenirNext-Medium";
    
    static let BACKGROUND_PLANET:String = "planet";
    static let BACKGROUND_PLANET_TOTAL:Int = 5;
    static let BACKGROUND_PLANET_SPEED:CGFloat = 0.4;
    
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
    
    
    static let SPACESHIP_EXPLOSION_FRAMES: Double = 0.02;
    static let SPACESHIP_MOVEMENT_FRAMES: Double = 0.05;
    
    static let ENEMY_CATEGORY: UInt32 = 1;
    
    // GENERAL
    
    
    
    // My Spaceship
    
    static let MYSPACESHIP_NAME:String = "spaceship-1";
    static let MYSPACESHIP_LEFT_NAME:String = "spaceship-1_left";
    static let MYSPACESHIP_RIGHT_NAME:String = "spaceship-1_right";
    static let MYSPACESHIP_THRUSTER_NAME:String = "thruster01";
    static let MYSPACESHIP_SPEED: CGFloat = 7;
    static let MYSPACESHIP_EXPLOSION: String = "Explosion0100";
    static let MYSPACESHIP_TILTLEFT_NAME:String = "spaceship_left";
    static let MYSPACESHIP_TILTRIGHT_NAME:String = "spaceship_right";

    
    static let MyMissle_Name:String = "missle";
    static let MyMissle_Frequency:Double = 0.35;
    
    
    //ROLLING ROCK A
    static let ROLLINGROCKA_NAME:String = "rollingrockA";
    static let ROLLINGROCKA_SPEED:CGFloat = 5;
    static let ROLLINGROCKA_HEALTH:Int = 1;
    static let ROLLINGROCKA_EXPLOSION:String = "Explosion0100";
    static let ROLLINGROCKA_SPAWN: Double = 2;
    static let ROLLINGROCKA_POINT: Int = 200;
    
    //ROLLING ROCK B
    static let ROLLINGROCKB_NAME:String = "RollingRockB";
    static let ROLLINGROCKB_SPEED:CGFloat = 5;
    static let ROLLINGROCKB_HEALTH:Int = 1;
    static let ROLLINGROCKB_EXPLOSION:String = "Explosion0100";
    static let ROLLINGROCKB_SPAWN: Double = 2;
    static let ROLLINGROCKB_ACC: CGFloat = 0.02;
    static let ROLLINGROCKB_POINT: Int = 300;
    
    //ENEMY SPACESHIP A
    static let ENEMYA_NAME:String = "EnemySpaceshipA";
    static let ENEMYA_SPEED:CGFloat = 2;
    static let ENEMYA_HEALTH:Int = 2;
    static let ENEMYA_EXPLOSION:String = "ExplosionB";
    static let ENEMYA_SPAWN: Double = 3;
    static let ENEMYA_POINT: Int = 500;
    static let ENEMYA_TILTLEFT_NAME:String = "EnemySpaceshipA_left";
    static let ENEMYA_TILTRIGHT_NAME:String = "EnemySpaceshipA_right";

    static let ENEMYA_Missle_Frequency:Double = 1;
    
    
    
    
}
