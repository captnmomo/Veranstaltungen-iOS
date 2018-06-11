//
//  EventInterfaceController.swift
//  Veranstaltungen Watch Extension
//
//  Created by momo on 10.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import WatchKit
import Foundation


class EventInterfaceController: WKInterfaceController {
    
    @IBOutlet var kategorieLabel: WKInterfaceLabel!
    
    var kategorieText: String = String()
    var preisText: String = String()
    var nameText: String = String()
    var idText: String = String()
    var longitudeText: String = String()
    var latitudeText: String = String()
    
    @IBAction func showMap() {
    }
    @IBOutlet var preisLabel: WKInterfaceLabel!
    @IBOutlet var imageView: WKInterfaceImage!
    @IBOutlet var nameLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        /*let arrayContext = context as? NSDictionary
        let kategorieText = arrayContext!["Kategorie"] as! String
        let preisText = arrayContext!["Preis"] as! String
        let nameText = arrayContext!["Name"] as! String
        let idText = arrayContext!["Id"] as! String*/
        
        let arrayContext = context as! NSArray
        kategorieText = arrayContext[0] as! String
        preisText = arrayContext[2] as! String
        nameText = arrayContext[1] as! String
        idText = arrayContext[3] as! String
        latitudeText = arrayContext[5] as! String
        longitudeText = arrayContext[4] as! String
        
        if let url = URL(string: "http://10.179.4.243:8888/getImage.php?id=" + idText) {
            downloadImage(url: url)
        }
        
        self.kategorieLabel.setText("Kategorie: " + self.kategorieText)
        self.preisLabel.setText("Preis: " + self.preisText + "€")
        self.nameLabel.setText(self.nameText)
    
        
        // Configure interface objects here.
    }
    
    @IBAction func mapButton() {
        let arrayContext = [latitudeText, longitudeText, nameText]
        self.pushController(withName: "mapView", context: arrayContext)
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView.setImageData(data)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
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
