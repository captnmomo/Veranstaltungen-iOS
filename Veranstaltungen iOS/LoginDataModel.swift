//
//  LoginDataModel.swift
//  Veranstaltungen iOS
//
//  Created by momo on 06.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

protocol LoginModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class LoginDataModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate: LoginModelProtocol!

    func loginCheck(uname: String, password: String) {
        
        let urlPath = "http://localhost:8888/login.php?user=" + uname + "&password=" + password;
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
            
            let login = LoginModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let uname = jsonElement["user"] as? String,
                let userrole = jsonElement["userrole"] as? String
            {
                
                login.uname = uname
                login.userrole = userrole
                
            }
            
            events.add(login)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: events)
            
        })
    }
}
