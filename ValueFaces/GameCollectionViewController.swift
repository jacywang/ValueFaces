//
//  GameCollectionViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/15/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ValueCell"

class GameCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    let spacing: CGFloat = 10.0
    let screenWidthDivider:CGFloat = 2.0
    var values = [Value]()
    var selectedValues = [Value]()
//    var doubleTapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        values = setValueCards()
        selectedValues = values
        setFlowlayout()
        setDoubleTapGesture()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        presentGuide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // MARK: Help Method
    
    func setFlowlayout() {
        let screenwidth = collectionView?.frame.width
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        flowLayout.scrollDirection = .Horizontal
        let cellWidth = (screenwidth! - 2 * flowLayout.minimumInteritemSpacing) / screenWidthDivider
        flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth + spacing * 3)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        
        collectionView?.setCollectionViewLayout(flowLayout, animated: true)
        collectionView?.backgroundColor = UIColor.manicCravingColor()
    }
    
    func setValueCards() -> [Value] {
        return [Value(imageName: "achievement", aText: "Achievement"),
            Value(imageName: "balance", aText: "Balance"),
            Value(imageName: "beauty", aText: "Beauty"),
            Value(imageName: "career", aText: "Career"),
            Value(imageName: "family", aText: "Family"),
            Value(imageName: "freedom", aText: "Freedom"),
            Value(imageName: "friendship", aText: "Friendship"),
            Value(imageName: "happiness", aText: "Happiness"),
            Value(imageName: "health", aText: "Health"),
            Value(imageName: "love", aText: "Love"),
            Value(imageName: "peace", aText: "Peace"),
            Value(imageName: "power", aText: "Power"),
            Value(imageName: "qualityofLife", aText: "Quality of Life"),
            Value(imageName: "recognition", aText: "Recognition"),
            Value(imageName: "respect", aText: "Respect"),
            Value(imageName: "responsibility", aText: "Responsibility"),
            Value(imageName: "stability", aText: "Stability"),
            Value(imageName: "time", aText: "Time"),
            Value(imageName: "wealth", aText: "Wealth"),
            Value(imageName: "wisdom", aText: "Wisdom"),
            
        ];
    }
    
    func presentGuide() {
        let alertController = UIAlertController(title: "First Round Guide", message: "There are twenty value cards and you can scroll horizontally to see the full list. In the first round, you need to get rid of eight value cards that are less important to you. Double tap to remove a card!", preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Start", style: UIAlertActionStyle.Default, handler: { action -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        alertController.addAction(alertAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setDoubleTapGesture() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapGesture.numberOfTapsRequired = 2
        collectionView?.addGestureRecognizer(doubleTapGesture)
    }
    
    func doubleTap(sender:UITapGestureRecognizer) {
        let touchLocation = sender.locationInView(collectionView)
        let cellIndexPath = collectionView?.indexPathForItemAtPoint(touchLocation)
        selectedValues.removeAtIndex((cellIndexPath?.row)!)
        collectionView?.reloadData()
//        if cellIndexPath != nil {
//            collectionView?.performBatchUpdates({ () -> Void in
//                self.collectionView?.deleteItemsAtIndexPaths([cellIndexPath])
//                }, completion: nil)
//        }
    }
}
