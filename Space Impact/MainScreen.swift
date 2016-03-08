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
    private var _name:String;
    
    private var _buttons:[Button];
    private var _labels:[Label];
    private var _gameScene:GameScene;
    
    private var _isStarted:Bool;
    private var _isHighScore:Bool;
    private var _isTutorial:Bool;
    private var _isActive:Bool;
    
    let _buttonPaddings:CGFloat = GeneralGameSettings.BUTTON_PADDINGS;
    
    var Name:String{get{return self._name}}
    
    var Buttons:[Button]{get{return self._buttons} set(val){self._buttons = val}}
    
    var IsActive:Bool{get{return self._isActive} set(val)
    {
        self._isActive = val;
        Transition();
    }}
    var IsStarted:Bool{get{return self._isStarted}set(val){self._isStarted = val}}
    var IsHighScore:Bool{get{return self._isHighScore}}
    var IsTutorial:Bool{get{return self._isTutorial}}
    
    init(gs:GameScene)
    {
        self._name = "Main";
        self._gameScene = gs;
        self._buttons = [Button]();
        self._labels = [Label]();
        self._isStarted = false;
        self._isTutorial = false;
        self._isHighScore = false;
        self._isActive = false;
        
        generateLabels();
        generateButtons();
        
    }
    
    private func generateButtons(){
        
        let btnStart = Button(gs: self._gameScene, displayText: "START".capitalizedString, position: CGPoint(x:CGRectGetMidX(self._gameScene.frame), y:CGRectGetMidY(self._gameScene.frame)*1.2), opacity: 0, fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
        
        let btnHighScore = Button(gs: self._gameScene, displayText: "HIGH SCORE".capitalizedString, position: CGPoint(x:CGRectGetMidX(self._gameScene.frame), y: btnStart.Position.y - btnStart.Height - _buttonPaddings), opacity: 0, fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
        
        let btnTutorial = Button(gs: self._gameScene, displayText: "TUTORIAL".capitalizedString, position: CGPoint(x:CGRectGetMidX(self._gameScene.frame), y: btnHighScore.Position.y - btnHighScore.Height - _buttonPaddings), opacity: 0, fontName:GeneralGameSettings.BUTTON_FONTFAMILY, fontSize:GeneralGameSettings.BUTTON_FONTSIZE, imageName:"none");
        
        _buttons.append(btnStart);
        _buttons.append(btnHighScore);
        _buttons.append(btnTutorial);

        
    }
    
    private func generateLabels(){
        let lblMainTitle = Label(gs: self._gameScene, displayText: "SPACE IMPACT", position: CGPoint(x:CGRectGetMidX(self._gameScene.frame), y:CGRectGetMidY(self._gameScene.frame)+150), fontSize: GeneralGameSettings.TITLE_FONTSIZE, fontNamed: GeneralGameSettings.TITLE_FONTFAMILY,opacity: 0);
        
        
        self._labels.append(lblMainTitle);
    }
    
    func Update(){
      
    }
    
    func Notify(targetStage:String){
        
    }
    
    func Transition(){
        if !self._isActive{
            DeActive();
        }
        else
        {
            self.Active();
        }

    }
    
    func Active(){
        let fadeInAnimation = SKAction.fadeInWithDuration(NSTimeInterval(GeneralGameSettings.TRANSITION_FADEIN));
        
        for button in self._buttons{
            if button.Sprite.alpha < 1
            {
                button.Sprite.runAction(fadeInAnimation);
                button.LabelNode.LabelNode.runAction(fadeInAnimation);
            }
        }
        
        for label in self._labels{
            if label.LabelNode.alpha < 1
            {
                label.LabelNode.runAction(fadeInAnimation);
            }
        }
    }
    
    func DeActive() {
        let fadeOutAnimation = SKAction.fadeOutWithDuration(NSTimeInterval(GeneralGameSettings.TRANSITION_FADEOUT));
        
        for button in self._buttons{
            
            if button.Sprite.alpha > 0
            {
                button.Sprite.runAction(fadeOutAnimation);
                button.LabelNode.LabelNode.runAction(fadeOutAnimation);
            }
        }
        
        for label in self._labels{
            if label.LabelNode.alpha>0
            {
                label.LabelNode.runAction(fadeOutAnimation);
            }
        }
    }
    
    func HandlesTouch(touch: UITouch, withEvent event: UIEvent?)
    {
        if !self._isActive
        {
            return;
        }
        
        for button in self._buttons{
            if button.IsTouched(touch, withEvent: event)
            {
                let curNodeName = button.Sprite.name == nil ? "" : button.Sprite.name!;
                switch curNodeName {
                    case "Start":
                        self._isStarted = true;
                    case "High_Score":
                        self._isHighScore = true;
                    case "Tutorial":
                        self._isTutorial = true;
                    default:
                        print("main menu error");
                }
            }
        }
    }
    
    func IsTouched(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if self._isActive
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}

enum MainMenuButtonType:Int{
    case Start=1,Help,Tutorial
    
}
