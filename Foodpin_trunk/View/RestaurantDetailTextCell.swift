//
//  RestaurantDetailTextCell.swift
//  Foodpin_trunk
//
//  Created by Aman on 2019/7/16.
//  Copyright © 2019 Aman. All rights reserved.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {

    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
