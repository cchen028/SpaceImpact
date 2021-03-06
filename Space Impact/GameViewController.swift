//
//  GameViewController.swift
//  Space Impact
//
//  Created by Chieh on 2/14/16.
//  Copyright (c) 2016 Jay. All rights reserved.
//

import UIKit
import SpriteKit




class GameViewController: UIViewController  {
    
    static let presentIAPModallySegueId = "presentIAPModallySegue"
    static let presentPauseMenuModallySegueId = "presentPauseMenuModallySegue"
    let transitionManager = TransitionManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  instance

//        for family: String in UIFont.familyNames
//        {
//            print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
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
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        <#code#>
//    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      //  if segue.identifier == "showImagePicker" {
            
        //print(segue.destination.tr);
        
      //  }

        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destination as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        
        
        
        //self.transitionManager.animateTransition(using: <#T##UIViewControllerContextTransitioning#>)

        
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
        NotificationCenter.default.addObserver(self, selector: #selector(presentPauseMenuViewController), name: .onPauseMenuButtonPressed, object: nil)
    }
    
    private func removeNotificationObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func presentIAPViewController(){
        performSegue(withIdentifier: GameViewController.presentIAPModallySegueId, sender: self);
    }
    
    @objc private func presentPauseMenuViewController(){
        performSegue(withIdentifier: GameViewController.presentPauseMenuModallySegueId, sender: self);
    }
}
