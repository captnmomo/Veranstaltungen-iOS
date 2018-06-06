//
//  TableViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 27.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, EventModelProtocol {
    //Properties
    
    var preis1passed = ""
    var preis2passed = ""
    var kategoriepassed = ""
    var umkreispassed = ""
    var feedItems: NSArray = NSArray()
    var selectedLocation : EventModel = EventModel()
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates and initialize homeModel
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let eventDataModel = EventDataModel()
        eventDataModel.delegate = self
        eventDataModel.downloadItems(preis1: preis1passed, preis2: preis2passed, kategorie: kategoriepassed, umkreis: umkreispassed)
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.listTableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "eventCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: EventModel = feedItems[indexPath.row] as! EventModel
        // Get references to labels of cell
        let itemData = item.name! + ", Preis: " + item.preis!
        myCell.textLabel!.text = itemData
        
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocation = feedItems[indexPath.row] as! EventModel
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "eventSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC  = segue.destination as! EventViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedLocation = selectedLocation
    }
}
