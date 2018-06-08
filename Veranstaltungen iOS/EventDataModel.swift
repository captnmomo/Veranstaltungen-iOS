//
//  HomeModel.swift
//  Veranstaltungen iOS
//
//  Created by momo on 05.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

protocol EventModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class EventDataModel: NSObject, URLSessionDataDelegate {

    //properties
    
    weak var delegate: EventModelProtocol!
    
    
    func downloadItems(preis1: String, preis2: String, kategorie: String, umkreis: String) {
        
        let urlPath = "http://localhost:8888/event.php?preis1=" + preis1 + "&preis2=" + preis2 + "&kategorie=" + kategorie;
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
               print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let events = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let event = EventModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if var name = jsonElement["Name"] as? String,
                let kategorie = jsonElement["Kategorie"] as? String,
                let preis = jsonElement["Preis"] as? String,
                let datum = jsonElement["Datum"] as? String,
                let longitude = jsonElement["longitude"] as? String,
                let latitude = jsonElement["latitude"] as? String,
                let id = jsonElement["id"] as? String,
                var website = jsonElement["website"] as? String,
                var beschreibung = jsonElement["Text"] as? String
            {
                name = name.replacingOccurrences(of: "ae", with: "ä")
                name = name.replacingOccurrences(of: "oe", with: "ö")
                name = name.replacingOccurrences(of: "ue", with: "ü")
                name = name.replacingOccurrences(of: "Ae", with: "Ä")
                name = name.replacingOccurrences(of: "Oe", with: "Ö")
                name = name.replacingOccurrences(of: "Ue", with: "Ü")
                
                beschreibung = beschreibung.replacingOccurrences(of: "ae", with: "ä")
                beschreibung = beschreibung.replacingOccurrences(of: "oe", with: "ö")
                beschreibung = beschreibung.replacingOccurrences(of: "ue", with: "ü")
                beschreibung = beschreibung.replacingOccurrences(of: "Ae", with: "Ä")
                beschreibung = beschreibung.replacingOccurrences(of: "Oe", with: "Ö")
                beschreibung = beschreibung.replacingOccurrences(of: "Ue", with: "Ü")
                
                website = website.replacingOccurrences(of: "ae", with: "ä")
                website = website.replacingOccurrences(of: "oe", with: "ö")
                website = website.replacingOccurrences(of: "ue", with: "ü")
                website = website.replacingOccurrences(of: "Ae", with: "Ä")
                website = website.replacingOccurrences(of: "Oe", with: "Ö")
                website = website.replacingOccurrences(of: "Ue", with: "Ü")
                
                event.name = name
                event.kategorie = kategorie
                event.preis = preis
                event.datum = datum
                event.latitude = latitude
                event.longitude = longitude
                event.id = id
                event.website = website
                event.beschreibung = beschreibung
                
            }
            
            events.add(event)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: events)
            
        })
    }
    
}
