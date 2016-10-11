//
//  DynamicString.swift
//  Space Impact
//
//  Created by Chieh on 10/9/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
class DynamicInt {
    typealias Listener = (Int) -> Void
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    var value: Int {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: Int) {
        value = v
    }
}
