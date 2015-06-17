//
//  ValueCollectionViewCell.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/15/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class ValueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var valueImageView: UIImageView!
    @IBOutlet weak var valueNameLabel: UILabel!
    let borderWidth: CGFloat = 1.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.clearColor().CGColor

        layer.cornerRadius = 5.0
        backgroundColor = UIColor.whiteColor()
    }
    
    func configure(value: Value) {
        valueNameLabel.text = value.text
        valueImageView.image = value.image
    }
}
