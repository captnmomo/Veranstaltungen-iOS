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
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.Bild.image = UIImage(data: data)
            }
        }
    }
    
    @IBOutlet weak var websiteField: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var beschreibungField: UITextView!
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var kategorieLabel: UILabel!
    @IBOutlet weak var preisLabel: UILabel!
    @IBOutlet weak var Bild: UIImageView!
    override func viewDidLoad() {
        datumLabel.text = selectedLocation!.datum!
        kategorieLabel.text = selectedLocation!.kategorie!
        preisLabel.text = selectedLocation!.preis! + "€"
        nameLabel.text = selectedLocation!.name!
        websiteField.isEditable = false
        websiteField.contentInset = UIEdgeInsetsMake(-6.0,0.0,0,0.0)
        websiteField.dataDetectorTypes = UIDataDetectorTypes.all
        websiteField.text = selectedLocation!.website!
        beschreibungField.text = selectedLocation!.beschreibung!
        
        if let url = URL(string: "https://gauss.wi.hm.edu/Veranstaltungen/getImage.php?id=" + selectedLocation!.id!) {
            Bild.contentMode = .scaleAspectFit
            downloadImage(url: url)
        }
        
        super.viewDidLoad()
        
        let userRole = "admin"
        
        if UserDefaults.standard.string(forKey: "userrole") == userRole {
            let moreButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(deleteEvent))
            navigationItem.rightBarButtonItem = moreButton
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func deleteEvent() {
        
        let URL_DELETE = "https://gauss.wi.hm.edu/Veranstaltungen/delete.php?id=" + selectedLocation!.id!;
        print(URL_DELETE)
        let url: URL = URL(string: URL_DELETE)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Event deleted")
                DispatchQueue.main.async{
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
                
            }
            
        }
        
        task.resume()
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
