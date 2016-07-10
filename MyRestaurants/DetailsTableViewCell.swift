//
//  DetailsTableViewCell.swift
//  MyRestaurants
//
//  Created by Vadim on 05.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var keyField: UILabel!
    @IBOutlet weak var valueField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
