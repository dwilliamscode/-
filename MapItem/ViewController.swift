//
//  ViewController.swift
//  MapItem
//
//  Created by dw on 2/13/15.
//  Copyright (c) 2015 WilliamsAssociates. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBook
import MapKit

class ViewController: UIViewController {

  @IBOutlet weak var address: UITextField!
  @IBOutlet weak var city: UITextField!
  @IBOutlet weak var state: UITextField!
  @IBOutlet weak var zip: UITextField!
  var coords: CLLocationCoordinate2D?
  
  @IBAction func getDirections(sender: AnyObject) {
    let geoCoder = CLGeocoder()
    
    let addressString = "\(address.text) \(city.text) \(state.text) \(zip.text)"
    
    geoCoder.geocodeAddressString(addressString, completionHandler: {(placemarks: [AnyObject]!, error:NSError!) in
      
      if error != nil {
        println("Geocode failed with error: \(error.localizedDescription)")
      } else if placemarks.count > 0 {
        let placemark = placemarks[0] as CLPlacemark
        let location = placemark.location
        self.coords = location.coordinate
        
        self.showMap()
      }
  })
  }
  
    func showMap() {
      let addressDict = [kABPersonAddressStreetKey as NSString: address.text,kABPersonAddressCityKey: city.text,
        kABPersonAddressStateKey: state.text,
        kABPersonAddressZIPKey: zip.text]
      
      let place = MKPlacemark(coordinate: coords!,
			     addressDictionary: addressDict)
      
      let mapItem = MKMapItem(placemark: place)
      
      let options = [MKLaunchOptionsDirectionsModeKey:
      MKLaunchOptionsDirectionsModeDriving]
      
      mapItem.openInMapsWithLaunchOptions(options)
    }
}
