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
        
        let btnStart = Button(displayText: "START".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.midY*1.2), fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
        
        let btnHighScore = Button(displayText: "HIGH SCORE".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y: btnStart.position.y - btnStart.Height - _buttonPaddings), fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
        
        let btnTutorial = Button(displayText: "TUTORIAL".capitalized, position: CGPoint(x:GameScene.instance!.frame.midX, y: btnHighScore.position.y - btnHighScore.Height - _buttonPaddings), fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
        
        _buttons.append(btnStart);
        _buttons.append(btnHighScore);
        _buttons.append(btnTutorial);    }
    
    fileprivate func generateLabels(){
        let lblMainTitle = Label(displayText: "SPACE IMPACT", position: CGPoint(x:GameScene.instance!.frame.midX, y:GameScene.instance!.frame.midY+150), fontSize: GeneralGameSettings.TITLE_FONTSIZE, fontNamed: GeneralGameSettings.TITLE_FONTFAMILY);
        
        self._labels.append(lblMainTitle);
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
                    case "Start":
                        self._isStarted = true;
                    case "High_Score":
                        self._isHighScore = true;
                    case "Tutorial":
                        self._isTutorial = true;
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
