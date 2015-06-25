//
//  GooglePlacesViewController.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/24/15.
//  Copyright © 2015 JWANG. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

protocol GooglePlacesViewControllerProtocol {
    func placeSelected(placeString: NSAttributedString)
}

class GooglePlacesViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: GooglePlacesViewControllerProtocol?
    var places = [GMSAutocompletePrediction]()
    var placesClient: GMSPlacesClient?

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "close")
        closeButton.style = UIBarButtonItemStyle.Done
        closeButton.tintColor = UIColor.manicCravingColor()
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.title = "Enter Address"
        
        searchBar.becomeFirstResponder()
        
        placesClient = GMSPlacesClient()
    }
    
    // MARK: - Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // Get the corresponding candy from our candies array
        let place = places[indexPath.row]
        
        let regularFont = UIFont.systemFontOfSize(UIFont.labelFontSize());
        let boldFont = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        
        let bolded = place.attributedFullText.mutableCopy() as! NSMutableAttributedString
        bolded.enumerateAttribute(kGMSAutocompleteMatchAttribute, inRange: NSMakeRange(0, bolded.length), options: []) { (value, range, _) -> Void in
            let font = (value == nil) ? regularFont : boldFont
            bolded.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        
        // Configure the cell
        cell.textLabel!.attributedText = bolded
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let place = places[indexPath.row]
        delegate?.placeSelected(place.attributedFullText)
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            self.places = []
            tableView.hidden = true
        } else {
            getPlaces(searchText)
        }
    }
    
    // MARK: - Helper Method
    func close() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        if isViewLoaded() && view.window != nil {
            let info: Dictionary = notification.userInfo!
            let keyboardSize: CGSize = (info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size)!
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
            
            tableView.contentInset = contentInsets;
            tableView.scrollIndicatorInsets = contentInsets;
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        if isViewLoaded() && view.window != nil {
            self.tableView.contentInset = UIEdgeInsetsZero
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero
        }
    }
    
    func getPlaces(searchText: NSString) {
        let vancouver = CLLocationCoordinate2DMake(49.246292, -123.116226)
        let northEast = CLLocationCoordinate2DMake(vancouver.latitude + 1, vancouver.longitude + 1)
        let southWest = CLLocationCoordinate2DMake(vancouver.latitude - 1, vancouver.longitude - 1)
        let bounds = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.NoFilter
        
        if searchText.length > 0 {
            print("Searching for '\(searchText)'")
            placesClient?.autocompleteQuery(searchText as String, bounds: bounds, filter: filter, callback: { (results, error) -> Void in
                if error != nil {
                    print("Autocomplete error \(error) for query '\(searchText)'")
                    return
                }
                
                print("Populating results for query '\(searchText)'")
                self.places = [GMSAutocompletePrediction]()
                
                self.places = results as! [GMSAutocompletePrediction]
                print(self.places)
                self.tableView.hidden = false
                self.tableView.reloadData()
            })
        } else {
            places = [GMSAutocompletePrediction]()
            tableView.reloadData()
        }
    }
}
