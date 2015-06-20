//
//  GoalListTableViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/19/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class GoalListTableViewController: UITableViewController {
    
    var topThreeValues = [Value]()

    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // Testing! should remove after test is completed.
        topThreeValues = [Value(imageName: "achievement", aText: "Achievement"),
            Value(imageName: "balance", aText: "Balance"),
            Value(imageName: "beauty", aText: "Beauty"),]
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = true
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return topThreeValues.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Test"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return topThreeValues[section].text
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
