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


    override func awake(withContext context: Any?) {
        
        print(defaultValues.double(forKey: "latitude"))
        
        defaultValues.removeObject(forKey: "latitude")
        defaultValues.removeObject(forKey: "longitude")
        
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
