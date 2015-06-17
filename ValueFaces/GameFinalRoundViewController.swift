//
//  GameFinalRoundViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/17/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class GameFinalRoundViewController: UIViewController {
    
    @IBOutlet weak var aView: ValueCardView!
    @IBOutlet weak var bView: ValueCardView!
    
    var topSixValues = [Value]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.manicCravingColor()
        
        print(topSixValues)
        
        aView.imageView.image = topSixValues[0].image
        aView.valueLabel.text = topSixValues[0].text
        bView.imageView.image = topSixValues[1].image
        bView.valueLabel.text = topSixValues[1].text
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
