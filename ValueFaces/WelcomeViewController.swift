//
//  ViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/15/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit
import CoreData

class WelcomeViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    
    let buttonBorderWith: CGFloat = 2.0
    let cornerRadiusDivider: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController!.tabBar.hidden = true
        navigationController?.navigationBarHidden = true
        setButtonLayer()

    }
    
    // MARK: Helper Method
    
    func setButtonLayer() {
        goButton.layer.borderWidth = buttonBorderWith
        goButton.layer.borderColor = UIColor.whiteColor().CGColor
        goButton.layer.cornerRadius = goButton.frame.size.height / cornerRadiusDivider
    }
}

