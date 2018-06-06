//
//  EventViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 06.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    var selectedLocation: EventModel?

    @IBAction func viewKarte(_ sender: Any) {
        self.performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC  = segue.destination as! MapViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedLocation = selectedLocation
    }
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var beschreibungField: UITextView!
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var kategorieLabel: UILabel!
    @IBOutlet weak var preisLabel: UILabel!
    @IBOutlet weak var Bild: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
