//
//  PauseMenuContainerViewController.swift
//  Space Impact
//
//  Created by Chieh on 6/17/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class PauseMenuContainerViewController: UIViewController {

    @IBOutlet var dismissGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func mainViewTapped(_ sender: AnyObject) {
        //        self.dismissViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismissViewController();
        GameObjectServices.instance.IsPaused = false;
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

extension PauseMenuContainerViewController{
    fileprivate func dismissViewController(){
        self.dismiss(animated: true, completion: nil)
    }
}


extension PauseMenuContainerViewController: UIGestureRecognizerDelegate{
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool{
        if gestureRecognizer == dismissGestureRecognizer{
            let isInView = gestureRecognizer.isInView(view: contentView)
            return !isInView //if the gesture is in the view, then we don't want to begin the gesture
        }
        return true
    }
}
