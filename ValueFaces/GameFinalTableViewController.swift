//
//  GameFinalTableViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/17/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit
import CoreData

class GameFinalTableViewController: UITableViewController {

    var topSixValues: [Value]!
    var snapshot: UIView?
    var sourceIndexPath: NSIndexPath?
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDoneButtonLayer()
        deleteOldRecordsInCoreData()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        tableView.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        StatusBarManager.setStatusBarBlack(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBarHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topSixValues!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ValueTableViewCell

        // Configure the cell...
        let value = topSixValues![indexPath.row]
        
        cell.valueImageView.image = value.image
        cell.valueLabel.text = value.text
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            topSixValues.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    }

    // MARK: Helper Method
    
    func setDoneButtonLayer() {
        doneButton.layer.borderWidth = 2.0
        doneButton.layer.borderColor = UIColor.whiteColor().CGColor
        doneButton.layer.cornerRadius = doneButton.frame.size.height / 2.0
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        let appDeledate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDeledate.managedObjectContext
        let entity = NSEntityDescription.entityForName("TopValue", inManagedObjectContext: managedContext)
        
        for value in topSixValues[0...2] {
            let topValue = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext:managedContext) as! TopValue
            
            topValue.setValue(value.text, forKey: "name")
            
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
        
        tabBarController?.selectedIndex = 0
        navigationController?.popToRootViewControllerAnimated(false)
    }
    
    func deleteOldRecordsInCoreData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "TopValue")
        
        var oldTopThreeValues = [TopValue]()
        
        do {
            oldTopThreeValues = try managedContext.executeFetchRequest(fetchRequest) as! [TopValue]
            // success ...
            if (oldTopThreeValues.first != nil) {
                for value in oldTopThreeValues {
                    managedContext.deleteObject(value)
                }
                
                do {
                    try managedContext.save()
                } catch {
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        

    }
    
    func longPressGestureRecognized(sender: UILongPressGestureRecognizer) {
        let state = sender.state as UIGestureRecognizerState
        let location = sender.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(location)
        
        switch state {
        case .Began:
            if let aIndexPath = indexPath {
                sourceIndexPath = aIndexPath
                let cell = tableView.cellForRowAtIndexPath(sourceIndexPath!) as! ValueTableViewCell
                snapshot = customSnapshotFromView(cell)
                var center = cell.center
                snapshot!.center = center
                snapshot!.alpha = 0.0
                tableView.addSubview(snapshot!)
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    //Offset for gesture location
                    center.y = location.y
                    self.snapshot!.center = center
                    self.snapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    self.snapshot!.alpha = 0.98
                    //Fade out
                    cell.alpha = 0.0
                    }, completion: { (finished:Bool) -> Void in
                        cell.hidden = true
                })
            }
        case .Changed:
            var center = snapshot!.center
            center.y = location.y
            if let aIndexPath = indexPath where indexPath != sourceIndexPath {
                let value = topSixValues[sourceIndexPath!.row]
                topSixValues.removeAtIndex(sourceIndexPath!.row)
                topSixValues.insert(value, atIndex: aIndexPath.row)
                tableView.moveRowAtIndexPath(sourceIndexPath!, toIndexPath: aIndexPath)
                sourceIndexPath = aIndexPath
            }
        default:
            let cell = tableView.cellForRowAtIndexPath(sourceIndexPath!) as! ValueTableViewCell
            cell.hidden = false
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.snapshot!.center = cell.center
                self.snapshot!.transform = CGAffineTransformIdentity
                self.snapshot!.alpha = 0.0
                cell.alpha = 1.0
                }, completion: { (finished: Bool) -> Void in
                    self.sourceIndexPath = nil
                    self.snapshot!.removeFromSuperview()
                    self.snapshot = nil
            })
        }
    }
    
    func customSnapshotFromView(inputView: UIView) -> UIView {
        //Make an image from the input view
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Create an image view
        let snapshot: UIView = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot
    }
}
