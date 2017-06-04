//
//  IAPProductTableViewCell.swift
//  Space Impact
//
//  Created by Daniel Lee on 5/29/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import StoreKit

class IAPProductTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    var product: SKProduct! //we NEED product before we can do anything
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProduct(product: SKProduct){
        self.product = product
    }
    
    func setDisplayContent(){
        self.productTitleLabel.text = self.product.localizedTitle
        
    }

}
