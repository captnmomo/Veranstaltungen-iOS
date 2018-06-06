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
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(name: String, kategorie: String, preis: String, datum: String) {
        
        self.name = name
        self.kategorie = kategorie
        self.preis = preis
        self.datum = datum
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(name), Kategorie: \(kategorie), Preis: \(preis), Datum: \(datum)"
        
    }
    
}
