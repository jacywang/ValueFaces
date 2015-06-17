//
//  Values.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/16/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

struct Value {
    let image: UIImage
    let text: String
    
    init(imageName:String, aText: String) {
        image = UIImage(named: imageName)!
        text = aText
    }
}
