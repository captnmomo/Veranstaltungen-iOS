//
//  InterfaceController.swift
//  Veranstaltungen Watch Extension
//
//  Created by momo on 10.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class InterfaceController: WKInterfaceController, CLLocationManagerDelegate, WatchEventModelProtocol {
    var feedItems: NSArray = NSArray()
    func itemsDownloaded(items: NSArray) {
        feedItems = items
    }
    
    
    var defaultValues = UserDefaults.standard
    var locationManager: CLLocationManager = CLLocationManager()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
       
        self.locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Configure interface objects here.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        defaultValues.set(location.coordinate.latitude, forKey: "latitude")
        defaultValues.set(location.coordinate.longitude, forKey: "longitude")
        print(defaultValues.double(forKey: "latitude"))
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
