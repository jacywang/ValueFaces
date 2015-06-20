//
//  TopThreeViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/18/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class TopThreeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goButton: UIButton!
    
    var topThreeValues = [Value]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setGoButtonLayer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = true
        navigationItem.hidesBackButton = true
        
        StatusBarManager.setStatusBarBlack(false)
        
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topThreeValues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TopThreeTableViewCell
        
        let value = topThreeValues[indexPath.row]
        
        cell.rankLabel.text = "\(indexPath.row + 1)"
        cell.valueImageView.image = value.image
        cell.valueLabel.text = value.text
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let goalListTableViewController = segue.destinationViewController as! GoalListTableViewController
        goalListTableViewController.topThreeValues = topThreeValues
    }
    
    // MARK: Helper Method
    
    func setGoButtonLayer() {
        goButton.layer.borderWidth = 2.0
        goButton.layer.borderColor = UIColor.whiteColor().CGColor
        goButton.layer.cornerRadius = goButton.frame.size.height / 2.0
    }

}
