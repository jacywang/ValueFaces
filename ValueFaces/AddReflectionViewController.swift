//
//  AddGoalViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/19/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class AddReflectionViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setButtonsLayer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        StatusBarManager.setStatusBarBlack(false)
        
        let pickerView = AKPickerView(frame: CGRectMake(0, 20, view.frame.width, 30))
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
//        pickerView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {
    }
    
    // MARK: - AKPickerView Data Source
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        switch item {
        case 0:
            return "Achievement"
        case 1:
            return "Reponsibility"
        case 2:
            return "Career"
        default:
            return ""
        }
        
    }
    
    // MARK: - AKPickerView Delegate
    
    // MARK: - Helper Method
    
    func setButtonsLayer() {
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = UIColor.whiteColor().CGColor
        cancelButton.layer.cornerRadius = cancelButton.frame.size.height / 2.0
        
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.borderColor = UIColor.whiteColor().CGColor
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 2.0
    }
}
