//
//  TopThreeTableViewCell.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/18/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class TopThreeTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
