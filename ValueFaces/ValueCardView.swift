//
//  ValueCardView.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/17/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class ValueCardView: UIView {

    let imageView = UIImageView()
    let valueLabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
        addSubview(imageView)
        addSubview(valueLabel)
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRectMake(0, 0, frame.width, frame.width)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    
        valueLabel.frame = CGRectMake(0, frame.width, frame.width, frame.height - frame.width)
        valueLabel.textAlignment = .Center
        valueLabel.textColor = UIColor.fontLightDarkColor()
    }
}
