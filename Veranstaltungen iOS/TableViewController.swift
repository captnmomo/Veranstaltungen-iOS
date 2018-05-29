//
//  TableViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 27.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, FeedModelProtocol {
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.eventResultsFeed.reloadData()
    }
    
    var feedItems: NSArray = NSArray()
    var selectedEvent : EventModel = EventModel()
    @IBOutlet var eventResultsFeed: UITableView!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.eventResultsFeed.delegate = self
        self.eventResultsFeed.dataSource = self
        
        let feedModel = FeedModel()
        feedModel.delegate = self
        feedModel.downloadItems()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "eventCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stock to be shown
        let item: EventModel = feedItems[indexPath.row] as! EventModel
        // Configure our cell title made up of name and price
        let titleStr: String = item.name! + ": " + item.preis!
        print(titleStr)
        // Get references to labels of cell
        myCell.textLabel!.text = titleStr
        
        return myCell
    }

}
