//
//  TodayViewController.swift
//  Veranstaltungen Today
//
//  Created by momo on 11.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

import NotificationCenter

import CoreLocation

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate, TodayEventModelProtocol {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var latitude: Double = Double()
    var longitude: Double = Double()
    var defaultValues = UserDefaults.standard
    
    var selectedLocation: EventModel?
    
    var locationEvent: CLLocation = CLLocation()
    var distance: Double = Double()
    
    var feedItems: NSArray = NSArray()
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        print("feed Items")
    }
        
    @IBOutlet weak var labelDistance4: UILabel!
    @IBOutlet weak var labelName4: UILabel!
    @IBOutlet weak var labelName3: UILabel!
    @IBOutlet weak var labelDistance3: UILabel!
    @IBOutlet weak var labelName2: UILabel!
    @IBOutlet weak var labelDistance2: UILabel!
    @IBOutlet weak var labelDistance1: UILabel!
    @IBOutlet weak var labelName1: UILabel!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage1(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image1.image = UIImage(data: data)
            }
        }
    }
    
    func downloadImage2(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image2.image = UIImage(data: data)
            }
        }
    }
    
    func downloadImage3(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image3.image = UIImage(data: data)
            }
        }
    }
    
    func downloadImage4(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image4.image = UIImage(data: data)
            }
        }
    }
    
    override func viewDidLoad() {
        labelName1.text = ""
        labelName2.text = ""
        labelName3.text = ""
        labelName4.text = ""
        labelDistance1.text = ""
        labelDistance2.text = ""
        labelDistance3.text = ""
        labelDistance4.text = ""
        self.locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        let eventDataModel = TodayModel()
        eventDataModel.delegate = self
            eventDataModel.downloadItems(latitude: self.latitude, longitude: self.longitude)
        }
        
        
        print("Test1")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        let myLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        if self.feedItems != nil && self.feedItems.count > 0 {
            if self.feedItems.count >= 1 {
        if let item: EventModel = self.feedItems[0] as? EventModel{
            self.locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
            self.distance = myLocation.distance(from: self.locationEvent) / 1000
        if let url = URL(string: "https://gauss.wi.hm.edu/Veranstaltungen/getImage.php?id=" + item.id!) {
            self.image1.contentMode = .scaleAspectFit
            self.downloadImage1(url: url)
        }
            self.labelName1.text = item.name!
            let distanceDouble = Double(round(self.distance*100)/100)
            self.labelDistance1.text = String(distanceDouble) + "km"
        }
        }
            
        if self.feedItems.count >= 2 {
        if let item: EventModel = self.feedItems[1] as? EventModel {
            self.locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
            self.distance = myLocation.distance(from: self.locationEvent) / 1000
        if let url = URL(string: "https://gauss.wi.hm.edu/Veranstaltungen/getImage.php?id=" + item.id!) {
            self.self.image2.contentMode = .scaleAspectFill
            self.downloadImage2(url: url)
        }
            self.labelName2.text = item.name!
            let distanceDouble = Double(round(self.distance*100)/100)
            self.labelDistance2.text = String(distanceDouble) + "km"
            
        }
            }
        
            if self.feedItems.count >= 3 {
        if let item: EventModel = self.feedItems[2] as? EventModel {
            self.locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
            self.distance = myLocation.distance(from: self.locationEvent) / 1000
        if let url = URL(string: "https://gauss.wi.hm.edu/Veranstaltungen/getImage.php?id=" + item.id!) {
            self.self.image3.contentMode = .scaleAspectFill
            self.downloadImage3(url: url)
        }
            self.labelName3.text = item.name!
            let distanceDouble = Double(round(self.distance*100)/100)
            self.labelDistance3.text = String(distanceDouble) + "km"
        }
            }
        
            if self.feedItems.count >= 4 {
        if let item: EventModel = self.feedItems[3] as? EventModel {
        self.locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
            self.distance = myLocation.distance(from: self.locationEvent) / 1000
        if let url = URL(string: "https://gauss.wi.hm.edu/Veranstaltungen/getImage.php?id=" + item.id!) {
            self.image4.contentMode = .scaleToFill
            self.downloadImage4(url: url)
        }
        self.labelName4.text = item.name!
            let distanceDouble = Double(round(self.distance*100)/100)
            self.labelDistance4.text = String(distanceDouble) + "km"
        }
        }
        }
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        print(latitude)
    }
    
}
