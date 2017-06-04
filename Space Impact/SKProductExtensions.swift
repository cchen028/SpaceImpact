//
//  SKProductExtensions.swift
//  Space Impact
//
//  Created by Daniel Lee on 6/3/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import StoreKit

extension SKProduct {
    
    func localizedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)!
    }
    
}
