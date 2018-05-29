//
//  EventModel.swift
//  Veranstaltungen iOS
//
//  Created by momo on 28.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class EventModel: NSObject {
    //properties of a stock
    
    var name: String?
    var preis: String?
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name and @price parameters
    
    init(name: String, preis: String) {
        
        self.name = name
        self.preis = preis
        
        
    }
    
    
    //prints a stock's name and price
    
    override var description: String {
        return "Name: \(String(describing: name)), Address: \(String(describing: preis))"
        
    }

}
