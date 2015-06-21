//
//  GoalListTableViewCell.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/21/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class GoalListTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(action: Action) {
        contentLabel.text = action.content
        
        let date = action.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let dateString = dateFormatter.stringFromDate(date)
        dateLabel.text = dateString
        
    }
}
