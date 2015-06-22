//
//  GoalListTableViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/19/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit
import CoreData

class GoalListTableViewController: UITableViewController {
    
    var topThreeValues = [TopValue]()
    var actionArray = [[Action]]()
    var animator: UIDynamicAnimator?
    var valuePopView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = true
        
        animator = UIDynamicAnimator(referenceView: tableView)
        
        fetchTopThreeValues()
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return topThreeValues.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionArray[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! GoalListTableViewCell

        // Configure the cell...
        cell.configure(actionArray[indexPath.section][indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return topThreeValues[section].name
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, self.tableView(tableView, heightForHeaderInSection: section)))
        headerView.backgroundColor = UIColor.manicCravingColor()
        let label = UILabel(frame: CGRectMake(10, 0, tableView.frame.width, self.tableView(tableView, heightForHeaderInSection: section)))
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let selectedAction = actionArray[indexPath.section][indexPath.row]
        
        if valuePopView == nil {
            createValuePopView(selectedAction)
        }
        
        let snapBahavior = UISnapBehavior(item: valuePopView!, snapToPoint: tableView.center)
        
        animator?.addBehavior(snapBahavior)
    }
    
    // MARK: - Setup Value Pop View
    
    func createValuePopView(action: Action) {
        valuePopView = UIView(frame: CGRectMake(0, -50, 250, 300))
        valuePopView?.backgroundColor = UIColor.manicCravingColor()
        valuePopView?.layer.cornerRadius = 10
        valuePopView?.layer.shadowColor = UIColor.blackColor().CGColor;
        valuePopView?.layer.shadowOffset = CGSizeMake(0, 10);
        valuePopView?.layer.shadowOpacity = 0.7;
        valuePopView?.layer.shadowRadius = 5.0;
        
        let textView = UITextView(frame: CGRectMake(10, 30, valuePopView!.frame.width - 20, 250))
        textView.backgroundColor = UIColor.clearColor()
        textView.textColor = UIColor.whiteColor()
        textView.text = action.content
        textView.font = UIFont(name: "Helvetica Neue", size: 17)
        textView.showsVerticalScrollIndicator = true
        valuePopView!.addSubview(textView)
        
        let closeButton = UIButton(type: .System)
        closeButton.frame = CGRectMake(valuePopView!.frame.width - 20, 0, 30, 30)
        closeButton.tintColor = UIColor.whiteColor()
        closeButton.setTitle("X", forState: .Normal)
        closeButton.addTarget(self, action: "dismissValuePopView:", forControlEvents: .TouchUpInside)
        valuePopView?.addSubview(closeButton)
        
        tableView.addSubview(valuePopView!)
    }
    
    func dismissValuePopView(sender: UIButton) {
        animator!.removeAllBehaviors()
        
        let gravityBehaviour = UIGravityBehavior(items: [valuePopView!])
        animator?.addBehavior(gravityBehaviour)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [valuePopView!])
        itemBehaviour.addAngularVelocity(-CGFloat(M_PI), forItem: valuePopView!)
        animator?.addBehavior(itemBehaviour)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.valuePopView!.alpha = 0
            }) { (finished: Bool) -> Void in
                self.valuePopView!.removeFromSuperview()
                self.valuePopView = nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Helper Method
    
    func fetchTopThreeValues() {
        if actionArray.count > 0 {
            actionArray.removeAll()
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "TopValue")
        
        do {
            topThreeValues = try managedContext.executeFetchRequest(fetchRequest) as! [TopValue]
            // success ...
            
            for value in topThreeValues {
                actionArray.append(value.action?.allObjects as! [Action])
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}
