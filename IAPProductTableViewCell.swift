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
    
    static let reuseIdentifier = "IAPProductTableViewCell"

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        setDisplayContent()
    }
    
    func setDisplayContent(){
        self.productTitleLabel.text = self.product.localizedTitle
        self.descriptionLabel.text = "" //TODO: fill this with other stuff later
        self.purchaseButton.setTitle(self.product.localizedPrice(), for: .normal)
        
    }

}
