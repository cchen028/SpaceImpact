//
//  GameViewController.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright (c) 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit




class GameViewController: UIViewController {
    
    static let presentIAPModallySegueId = "presentIAPModallySegue"

    override func viewDidLoad() {
        super.viewDidLoad()
      //  instance
        
        self.view.isMultipleTouchEnabled = true;
        
       // if let scene = GameScene(fileNamed:"GameScene") {
          if let scene = GameScene.instance {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true

            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
          
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.scaleMode = .resizeFill;
            
            skView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationObserver()
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    //MARK: - private methods
    private func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(presentIAPViewController), name: .onPowerUpButtonPressed, object: nil)
    }
    
    private func removeNotificationObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func presentIAPViewController(){
        performSegue(withIdentifier: GameViewController.presentIAPModallySegueId, sender: self)
    }
}
