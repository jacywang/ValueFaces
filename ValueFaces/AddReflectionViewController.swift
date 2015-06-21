//
//  AddGoalViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/19/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit
import CoreData

class AddReflectionViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate, UITextViewDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var topThreeValues = [TopValue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setButtonsLayer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        StatusBarManager.setStatusBarBlack(false)
        
        fetchTopThreeValues()
        
        let pickerView = AKPickerView(frame: CGRectMake(0, 20, view.frame.width, 30))
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {
    }
    
    // MARK: - Text View Delegate
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "Write here ..." {
            textView.text = ""
        }
    }
    
    // MARK: - AKPickerView Data Source
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        switch item {
        case 0:
            return topThreeValues[0].name!
        case 1:
            return topThreeValues[1].name!
        case 2:
            return topThreeValues[2].name!
        default:
            return ""
        }
        
    }
    
    // MARK: - AKPickerView Delegate
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        //
    }
    
    // MARK: - Helper Method
    
    func setButtonsLayer() {
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.borderColor = UIColor.whiteColor().CGColor
        cancelButton.layer.cornerRadius = cancelButton.frame.size.height / 2.0
        
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.borderColor = UIColor.whiteColor().CGColor
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 2.0
    }
    
    func fetchTopThreeValues() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "TopValue")
        
        do {
            topThreeValues = try managedContext.executeFetchRequest(fetchRequest) as! [TopValue]
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}
