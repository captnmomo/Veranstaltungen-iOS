//
//  LocationModel.swift
//  Veranstaltungen iOS
//
//  Created by momo on 05.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class EventModel: NSObject {

    //properties
    
    var name: String?
    var kategorie: String?
    var preis: String?
    var datum: String?
    var latitude: String?
    var longitude: String?
    var id: String?
    var website: String?
    var beschreibung: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(name: String, kategorie: String, preis: String, datum: String, latitude: String, longitude: String, id: String, website: String, beschreibung: String) {
        
        self.name = name
        self.kategorie = kategorie
        self.preis = preis
        self.datum = datum
        self.latitude = latitude
        self.longitude = longitude
        self.id = id
        self.website = website
        self.beschreibung = beschreibung
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(name), Kategorie: \(kategorie), Preis: \(preis), Datum: \(datum), latitude: \(latitude), longitude: \(longitude), id: \(id), website: \(website)"
        
    }
    
}
