//
//  TopThreeViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/18/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit
import CoreData

class TopThreeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goButton: UIButton!
    
    var topThreeValues: [TopValue]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.selectedIndex = 0
        
        fetchTopThreeValues()
        
        navigationController?.navigationBarHidden = true
        navigationItem.hidesBackButton = true
        setGoButtonLayer()
        StatusBarManager.setStatusBarBlack(false)
        tabBarController!.tabBar.hidden = false
        
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TopThreeTableViewCell
        
        if topThreeValues?.count > 0 {
            let value = topThreeValues![indexPath.row]
            
            cell.rankLabel.text = "\(indexPath.row + 1)"
            cell.valueImageView.image = UIImage(named: value.name!.lowercaseString)
            cell.valueLabel.text = value.name
        }
        return cell
    }
    
    // MARK: Helper Method
    
    func setGoButtonLayer() {
        goButton.layer.borderWidth = 2.0
        goButton.layer.borderColor = UIColor.whiteColor().CGColor
        goButton.layer.cornerRadius = goButton.frame.size.height / 2.0
    }

    func fetchTopThreeValues() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "TopValue")
        
        do {
            topThreeValues = try managedContext.executeFetchRequest(fetchRequest) as? [TopValue]
            // success ...
            
            if topThreeValues?.count == 0 {
                tabBarController?.selectedIndex = 1
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}
