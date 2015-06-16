//
//  GameCollectionViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/15/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ValueCell"

class GameCollectionViewController: UICollectionViewController {
    
    let spacing: CGFloat = 10.0
    let screenWidthDivider:CGFloat = 2.0
    let values = ["Quality of Life", "Stability", "Happiness", "Health", "Achievement", "Family", "Balance", "Wisdom", "Friendship", "Respect", "Recognition", "Freedom", "Love", "Peace", "Wealth", "Time", "Beauty", "Power", "Responsibility", "Career"]
    var selectedValues = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedValues = values
        self.setFlowlayout()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Help Method
    
    func setFlowlayout() {
        let screenwidth = collectionView?.frame.width
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        let cellWidth = (screenwidth! - 2 * flowLayout.minimumInteritemSpacing) / screenWidthDivider
        flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth / 2.0)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        
        collectionView?.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedValues.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ValueCollectionViewCell
    
        let value = selectedValues[indexPath.row]
        
        // Configure the cell
        cell.configure(value)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
