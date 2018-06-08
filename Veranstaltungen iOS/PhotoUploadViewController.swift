//
//  PhotoUploadViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 27.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class PhotoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var namePassed = String()
    var kategoriePassed = String()
    var preisPassed = String()
    var datumPassed = String()
    var strassePassed = String()
    var hausnummerPassed = String()
    var ortPassed = String()
    var websitePassed = String()
    var beschreibungPassed = String()
    var longitude = String()
    var latitude = String()

    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strasseCorrect = strassePassed.folding(options: .diacriticInsensitive, locale: .current)
        let strasseSS = strasseCorrect.uppercased(with: .current)
        let strassess = strasseSS.lowercased(with: .current)
        let ortCorrect = ortPassed.folding(options: .diacriticInsensitive, locale: .current)
        
        let urlPath = "https://maps.googleapis.com/maps/api/geocode/json?address=" + strassess + "%20" + hausnummerPassed + ",%20" + ortCorrect + "&key=AIzaSyCi9HwD2zrfPCgZ-ILzfdISlGeGr0pfMfU";
        print(urlPath)
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSONGoogle(data!)
            }
            
        }
        
        task.resume()
        
        beschreibungPassed = beschreibungPassed.replacingOccurrences(of: "ä", with: "ae")
        beschreibungPassed = beschreibungPassed.replacingOccurrences(of: "ö", with: "oe")
        beschreibungPassed = beschreibungPassed.replacingOccurrences(of: "ü", with: "ue")
        beschreibungPassed = beschreibungPassed.replacingOccurrences(of: "Ä", with: "Ae")
        beschreibungPassed = beschreibungPassed.replacingOccurrences(of: "Ö", with: "Oe")
        beschreibungPassed = beschreibungPassed.replacingOccurrences(of: "Ü", with: "Ue")
        beschreibungPassed = beschreibungPassed.replacingOccurrences(of: "ß", with: "ss")
        
        ortPassed = ortPassed.replacingOccurrences(of: "ä", with: "ae")
        ortPassed = ortPassed.replacingOccurrences(of: "ö", with: "oe")
        ortPassed = ortPassed.replacingOccurrences(of: "ü", with: "ue")
        ortPassed = ortPassed.replacingOccurrences(of: "Ä", with: "Ae")
        ortPassed = ortPassed.replacingOccurrences(of: "Ö", with: "Oe")
        ortPassed = ortPassed.replacingOccurrences(of: "Ü", with: "Ue")
        ortPassed = ortPassed.replacingOccurrences(of: "ß", with: "ss")
        
        strassePassed = strassePassed.replacingOccurrences(of: "ä", with: "ae")
        strassePassed = strassePassed.replacingOccurrences(of: "ö", with: "oe")
        strassePassed = strassePassed.replacingOccurrences(of: "ü", with: "ue")
        strassePassed = strassePassed.replacingOccurrences(of: "Ä", with: "Ae")
        strassePassed = strassePassed.replacingOccurrences(of: "Ö", with: "Oe")
        strassePassed = strassePassed.replacingOccurrences(of: "Ü", with: "Ue")
        strassePassed = strassePassed.replacingOccurrences(of: "ß", with: "ss")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func picker(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    @IBAction func upload(_ sender: Any) {
        
        let img:UIImage = ImageView.image!
        
        let todo: String =  "http://localhost:8888/upload.php"
        
        guard let url = URL(string: todo) else {
            print("Error: cannot create URL")
            return
        }
        
        let author = UserDefaults.standard.string(forKey: "username")!
        print(longitude)
        print(latitude)
        print(websitePassed)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date = dateFormatterPrint.date(from: datumPassed)
        let datumCorrect = dateFormatterGet.string(from: date!)
        
        let params = [
            "name": namePassed,
            "kategorie": kategoriePassed,
            "preis": preisPassed,
            "datum": datumCorrect,
            "beschreibung": beschreibungPassed,
            "longitude": longitude,
            "latitude": latitude,
            "strasse": strassePassed,
            "hausnummer": hausnummerPassed,
            "ort": ortPassed,
            "author": author,
            "website": websitePassed
            ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData: Data = UIImageJPEGRepresentation(ImageView.image!, 1)!
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: "file", imageDataKey: imageData, boundary: boundary) as Data
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
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
            print("error")
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
        
        
        //the following insures none of the JsonElement values are nil through optional binding
        if let message = jsonElement["message"] as? String{
            print("message: " + message)
    }
    
    }
    }
    func parseJSONGoogle(_ data:Data) {
        
        var jsonResult = NSDictionary()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
        } catch let error as NSError {
            print(error)
            
        }
        
        
        //the following insures none of the JsonElement values are nil through optional binding
        if let jsonElement = jsonResult["results"] as? NSArray{
            if let jsonElementi = jsonElement[0] as? NSDictionary{
                if let geometry = jsonElementi["geometry"] as? NSDictionary {
                    if let location = geometry["location"] as? NSDictionary {
                        let myVC = storyboard?.instantiateViewController(withIdentifier: "photoView") as! PhotoUploadViewController
                        let latitudeNumber = location["lat"] as? NSNumber
                        let longitudeNumber = location["lng"] as? NSNumber
                        longitude = String(format:"%f", longitudeNumber!.doubleValue)
                        latitude = String(format:"%f", latitudeNumber!.doubleValue)
                        print(latitude)
                        
                    }
                }
            }
        }
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }

        
}
extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
