//
//  ProfileViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/23/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, GooglePlacesViewControllerProtocol {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if PFUser.currentUser() != nil{
            usernameTextField.text = PFUser.currentUser()!.username
        } else {
            usernameTextField.text = "username"
        }
        
        setCameraButtonShape()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLocation" {
            let googlePlacesViewController = segue.destinationViewController as! GooglePlacesViewController
            googlePlacesViewController.delegate = self
        }
    }
    
    @IBAction func cameraButtonPressed(sender: UIButton) {
        
    }
    
    // MARK: - GooglePlaces View Controller Protocol
    func placeSelected(placeString: NSAttributedString) {
        locationButton.setTitle(placeString.string, forState: UIControlState.Normal)
        print(placeString.string)
    }
    
    // MARK: - Helper Method
    func setCameraButtonShape() {
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2.0
        cameraButton.layer.borderWidth = 1.0
        cameraButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        cameraButton.contentMode = UIViewContentMode.ScaleAspectFit
        cameraButton.clipsToBounds = true
    }
    
}