//
//  TableInterfaceController.swift
//  Veranstaltungen Watch Extension
//
//  Created by momo on 10.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation

class TableInterfaceController: WKInterfaceController, WatchEventModelProtocol, CLLocationManagerDelegate {
    
    var defaultValues = UserDefaults.standard
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double = Double()
    var longitude: Double = Double()
    
    var selectedLocation : WatchEventModel = WatchEventModel()
    
    var feedItems: NSArray = NSArray()
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        print("feed Items")
    }
    

    @IBOutlet var tableOutlet: WKInterfaceTable!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Configure interface objects here.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        let eventDataModel = WatchEventDataModel()
        eventDataModel.delegate = self
        eventDataModel.downloadItems(latitude: self.latitude, longitude: self.longitude)
        }
        
       DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
        
        self.tableOutlet.setNumberOfRows(self.feedItems.count, withRowType: "row")
        
        print(self.feedItems.count)
        
        for i in 0 ..< self.feedItems.count
        {
            print("Row")
            let row = self.tableOutlet.rowController(at: i) as? rowController
            let item: WatchEventModel = self.feedItems[i] as! WatchEventModel
            let labelValue = item.name!
            
            row!.rowLabel.setText(labelValue)
        }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        print(location.coordinate.latitude)
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        selectedLocation = feedItems[rowIndex] as! WatchEventModel
       let arrayContext = [selectedLocation.kategorie!, selectedLocation.name!, selectedLocation.preis!, selectedLocation.id!, selectedLocation.longitude, selectedLocation.latitude]
        
        print(selectedLocation.name!)
        // Manually call segue to detail view controller
        self.pushController(withName: "eventView", context: arrayContext)
    }
    
    /*func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        //build a context for the data
        var avgPace = RunData.paceSeconds(runData.avgPace(rowIndex))
        let context: AnyObject = avgPace as AnyObject
        presentControllerWithName("Info", context: context) //present the viewcontroller
    }*/

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

}
