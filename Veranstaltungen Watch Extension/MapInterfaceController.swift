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


class MapInterfaceController: WKInterfaceController, WKCrownDelegate {
    
    
    
    var latitude: String = String()
    var longitude: String = String()
    var nameText: String = String()

    @IBAction func changeView(_ value: Float) {
        
        let degrees:CLLocationDegrees = CLLocationDegrees(value / 450)
        
        let span = MKCoordinateSpanMake(degrees, degrees)
        let region = MKCoordinateRegionMake(poiCoodinates, span)
        
        MapView.setRegion(region)
        
    }
    var viewRegion: MKCoordinateRegion = MKCoordinateRegion()
    var poiCoodinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    @IBOutlet var MapView: WKInterfaceMap!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
       
        let arrayContext = context as! NSArray
        latitude = arrayContext[0] as! String
        longitude = arrayContext[1] as! String
        nameText = arrayContext[2] as! String
        
        poiCoodinates.latitude = CDouble(latitude)!
        poiCoodinates.longitude = CDouble(longitude)!
        // Zoom to region
        viewRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 300, 300)
        // Create coordinates from location lat/long
        self.MapView.setRegion(viewRegion)
        self.MapView.addAnnotation(poiCoodinates, with: .red)
    
        
        // Configure interface objects here.
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
