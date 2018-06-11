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

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate, WatchEventModelProtocol {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var defaultValues = UserDefaults.standard
    
    var selectedLocation: WatchEventModel?
    
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
        self.locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let myLocation = CLLocation(latitude: defaultValues.double(forKey: "latitude"), longitude: defaultValues.double(forKey: "longitude"))
        
        let eventDataModel = WatchEventDataModel()
        eventDataModel.delegate = self
        eventDataModel.downloadItems()
        
        print("Test1")
        
            var item: WatchEventModel = self.feedItems[0] as! WatchEventModel
            var locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
            var distance = myLocation.distance(from: locationEvent) / 1000
        if let url = URL(string: "http://localhost:8888/getImage.php?id=" + item.id!) {
            image1.contentMode = .scaleAspectFit
            downloadImage1(url: url)
        }
        labelName1.text = item.name!
        labelDistance1.text = String(distance) + "km"
        
        item = self.feedItems[1] as! WatchEventModel
        locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
        distance = myLocation.distance(from: locationEvent) / 1000
        if let url = URL(string: "http://localhost:8888/getImage.php?id=" + item.id!) {
            image2.contentMode = .scaleAspectFit
            downloadImage2(url: url)
        }
        labelName2.text = item.name!
        labelDistance2.text = String(distance) + "km"
        
        item = self.feedItems[2] as! WatchEventModel
        locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
        distance = myLocation.distance(from: locationEvent) / 1000
        if let url = URL(string: "http://localhost:8888/getImage.php?id=" + item.id!) {
            image3.contentMode = .scaleAspectFit
            downloadImage3(url: url)
        }
        labelName3.text = item.name!
        labelDistance3.text = String(distance) + "km"
        
        item = self.feedItems[3] as! WatchEventModel
        locationEvent = CLLocation(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
        distance = myLocation.distance(from: locationEvent) / 1000
        if let url = URL(string: "http://localhost:8888/getImage.php?id=" + item.id!) {
            image4.contentMode = .scaleAspectFit
            downloadImage4(url: url)
        }
        labelName4.text = item.name!
        labelDistance4.text = String(distance) + "km"
            
        
        
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
        defaultValues.set(location.coordinate.latitude, forKey: "latitude")
        defaultValues.set(location.coordinate.longitude, forKey: "longitude")
    }
    
}
