//
//  UIGestureRecognizer+Extensions.swift
//  Space Impact
//
//  Created by Daniel Lee on 10/22/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
import UIKit

extension UIGestureRecognizer{
    func isInView(view: UIView)->Bool{
        let point = self.location(in: view)
        let isXOutOfView = point.x < 0 || point.x > view.frame.width
        let isYoutOfView = point.y < 0 || point.y > view.frame.height
        
        return !(isXOutOfView || isYoutOfView)
    }
}
