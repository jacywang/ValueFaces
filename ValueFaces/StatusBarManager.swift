//
//  StatusBarManager.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/18/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class StatusBarManager {
    class func setStatusBarBlack(black: Bool) {
        if black {
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        } else {
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        }
    }
}