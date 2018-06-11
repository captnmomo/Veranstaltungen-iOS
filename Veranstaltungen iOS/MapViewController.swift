//
//  MapViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 06.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var Map: MKMapView!
    
    var selectedLocation : EventModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func navigationEvent(_ sender: Any) {
        var poiCoodinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        poiCoodinates.latitude = CDouble(self.selectedLocation!.latitude!)!
        poiCoodinates.longitude = CDouble(self.selectedLocation!.longitude!)!
        // Zoom to region
        let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: viewRegion.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: viewRegion.span)]
        let placemark = MKPlacemark(coordinate: poiCoodinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = selectedLocation!.name!
        mapItem.openInMaps(launchOptions: options)
    }
    override func viewDidAppear(_ animated: Bool) {
        var poiCoodinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
        
        poiCoodinates.latitude = CDouble(self.selectedLocation!.latitude!)!
        poiCoodinates.longitude = CDouble(self.selectedLocation!.longitude!)!
        // Zoom to region
        let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750)
        // Create coordinates from location lat/long
        self.Map.setRegion(viewRegion, animated: true)
        // Plot pin
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = poiCoodinates
        //pin.title =
        self.Map.addAnnotation(pin)
        
        //add title to the pin
        pin.title = selectedLocation!.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
