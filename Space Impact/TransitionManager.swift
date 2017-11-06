//
//  TransitionManager.swift
//  Space Impact
//
//  Created by Chieh on 6/16/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class TransitionManager: NSObject,  UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView
        let fromView:UIView! = transitionContext.view(forKey: UITransitionContextViewKey.from) ?? transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        let toView:UIView! = transitionContext.view(forKey: UITransitionContextViewKey.to) ?? transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
    
        
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
       // let test = CGAffineTransform(
        
        // start the toView to the right of the screen
       // toView.transform = offScreenRight
        
        fromView.alpha = 1;
        toView.alpha = 0;
     
        
        
        // add the both views to our view controller
        container.addSubview(fromView)
        container.addSubview(toView)
        

        let duration = self.transitionDuration(using: transitionContext)

        
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            
          //  fromView.alpha = 0
            toView.alpha = 1
           // toView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5);
            
           // toView.backgroundColor.op
            
        }, completion: { finished in
            
            // tell our transitionContext object that we've finished animating
            transitionContext.completeTransition(true);
            //container.addSubview(toView)
            // fromView.alpha = 1
             UIApplication.shared.keyWindow?.addSubview(screens.to.view)
            
//            if let window = UIApplication.shared.keyWindow {
//                if let viewController = window.rootViewController {
//                    window.addSubview(viewController.view)
//                }
//            }
            
        })
    }
    
    
    // return how many seconds the transiton animation will take
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}

