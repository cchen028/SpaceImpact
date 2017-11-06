//
//  MainScreen.swift
//  Space Impact
//
//  Created by Chieh on 2/27/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit

class MainScreen: IStage,ITouchable {
    fileprivate var _name:String;
    
    fileprivate var _buttons:[Button];
    fileprivate var _labels:[Label];    
    fileprivate var _isStarted:Bool;
    fileprivate var _isHighScore:Bool;
    fileprivate var _isTutorial:Bool;
    fileprivate var _isActive:Bool;
    
    let _buttonPaddings:CGFloat = GeneralGameSettings.BUTTON_PADDINGS;
    
    var Name:String{get{return self._name}}
    var Buttons:[Button]{get{return self._buttons} set(val){self._buttons = val}}
    var IsActive:Bool{get{return self._isActive}}
    var IsStarted:Bool{get{return self._isStarted}set(val){self._isStarted = val}}
    var IsHighScore:Bool{get{return self._isHighScore}}
    var IsTutorial:Bool{get{return self._isTutorial}}
    
    init()
    {
        self._name = "Main";
        self._buttons = [Button]();
        self._labels = [Label]();
        self._isStarted = false;
        self._isTutorial = false;
        self._isHighScore = false;
        self._isActive = false;
        
        generateLabels();
        generateButtons();
    }
    
    fileprivate func generateButtons(){
        
//        let btnStart = Button(displayText: "START".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.midY*1.2),  fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
//
//        
//        let btnHighScore = Button(displayText: "HIGH SCORE".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y: btnStart.position.y - btnStart.Height - _buttonPaddings), fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
//        
//        let btnTutorial = Button(displayText: "TUTORIAL".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y: btnHighScore.position.y - btnHighScore.Height - _buttonPaddings),  fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
//        
//        let btnPowerUp = Button(displayText: "POWER UP".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y: btnTutorial.position.y - btnTutorial.Height - _buttonPaddings),  fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
        
        let btnNewGame = Button(displayText: "".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX + 20, y:GameScene.instance!.frame.midY*1.2),  fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:GeneralGameSettings.NEWGAME_NAME);
        
        
        let btnHighScore = Button(displayText: "".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX + 20, y: btnNewGame.position.y - btnNewGame.Height - _buttonPaddings), fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:GeneralGameSettings.HIGHSCORE_NAME);
        
        let btnSettings = Button(displayText: "".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX + 20, y: btnHighScore.position.y - btnHighScore.Height - _buttonPaddings),  fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:GeneralGameSettings.SETTINGS_NAME);
        
        let btnShop = Button(displayText: "".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX + 20, y: btnSettings.position.y - btnSettings.Height - _buttonPaddings),  fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:GeneralGameSettings.SHOP_NAME);
        
        let lblMainTitle = Button(displayText: "".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.midY+210),  fontName:GeneralGameSettings.TITLE_FONTFAMILY, fontSize:GeneralGameSettings.TITLE_FONTSIZE, imageName:GeneralGameSettings.TITLE_NAME);
        
        btnNewGame.name = "New_Game";
        btnHighScore.name = "High_Score";
        btnSettings.name = "Settings";
        btnShop.name = "Shop";
        lblMainTitle.setScale(0.5);
        
        _buttons.append(btnNewGame);
        _buttons.append(btnHighScore);
        _buttons.append(btnSettings);
        _buttons.append(btnShop)
        _buttons.append(lblMainTitle)
    }
    
    fileprivate func generateLabels(){
//        let lblMainTitle = Label(displayText: "SPACE IMPACT", position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.midY+150), fontSize: GeneralGameSettings.TITLE_FONTSIZE, fontNamed: GeneralGameSettings.TITLE_FONTFAMILY);
        
//         let lblMainTitle = Label(displayText: "", position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.midY+210), fontSize: GeneralGameSettings.TITLE_FONTSIZE, fontNamed: GeneralGameSettings.TITLE_FONTFAMILY);
        
        //self._labels.append(lblMainTitle);
    }
    
    func Update(){
      
    }
    
    func SetActive(_ isActive: Bool) {
        if(isActive){
            create();
        }
        else
        {
            destroy();
        }
        
        self._isActive = isActive;
    }
    
    
    
    func HandlesTouch(_ touch: UITouch, withEvent event: UIEvent?)
    {
        if !self._isActive
        {
            return;
        }
        
        for button in self._buttons{
            if button.IsTouched(touch, withEvent: event)
            {
                let curNodeName = button.name == nil ? "" : button.name!;
                switch curNodeName {
                    case "New_Game":
                        self._isStarted = true;
                    case "High_Score":
                        self._isHighScore = true;
                    case "Settings":
                        self._isTutorial = true;
                    case "Shop":
                        NotificationCenter.default.post(name: .onPowerUpButtonPressed, object: nil)
                    default:
                        print("main menu error", terminator: "");
                }
            }
        }
    }
    
    func IsTouched(_ touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if self._isActive
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    
    func Notify(_ targetStage:String){}
    
    fileprivate func create(){
        for button in self._buttons{
            button.FadeIn();
        }
        
        for label in self._labels{
            label.FadeIn();
        }
    }
    
    fileprivate func destroy() {
        for button in self._buttons{
            button.FadeOut();
        }
        
        for label in self._labels{
            label.FadeOut();
        }
    }
}

enum MainMenuButtonType:Int{
    case start=1,help,tutorial
    
}
