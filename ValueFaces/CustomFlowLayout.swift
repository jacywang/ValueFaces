//
//  CustomFlowLayout.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/17/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
 
    var deleteIndexPaths = [NSIndexPath]()
    
    override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
        super.prepareForCollectionViewUpdates(updateItems)
        for update in updateItems {
            if update.updateAction == .Delete {
                deleteIndexPaths.append(update.indexPathBeforeUpdate)
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        deleteIndexPaths = []
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath)
        
        if deleteIndexPaths.contains(itemIndexPath) {
            // only change attributes on deleted cells
            if attributes != nil {
                attributes = self.layoutAttributesForItemAtIndexPath(itemIndexPath);
            }
            // Configure attributes ...
            let rect = attributes!.frame;
            attributes!.frame = CGRectMake(collectionView!.center.x, collectionView!.bounds.size.height, rect.width, rect.height)
            attributes!.alpha = 0.5
        }
        
        return attributes;
    }
}
