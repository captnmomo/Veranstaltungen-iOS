//
//  MapInterfaceController.swift
//  Veranstaltungen Watch Extension
//
//  Created by momo on 10.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import WatchKit
import Foundation
import MapKit


class MapInterfaceController: WKInterfaceController {
    
    var latitude: String = String()
    var longitude: String = String()
    var nameText: String = String()

    @IBOutlet var MapView: WKInterfaceMap!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let arrayContext = context as! NSArray
        latitude = arrayContext[0] as! String
        longitude = arrayContext[1] as! String
        nameText = arrayContext[2] as! String
        var poiCoodinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        poiCoodinates.latitude = CDouble(latitude)!
        poiCoodinates.longitude = CDouble(longitude)!
        // Zoom to region
        let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750)
        // Create coordinates from location lat/long
        self.MapView.setRegion(viewRegion)
        self.MapView.addAnnotation(poiCoodinates, with: .red)
        
        // Configure interface objects here.
    }

    @IBAction func buttonDirections() {
        
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
