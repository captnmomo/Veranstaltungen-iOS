//
//  PhotoUploadViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 27.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class PhotoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var namePassed = ""
    var kategoriePassed = ""
    var preisPassed = ""
    var datumPassed = ""
    var strassePassed = ""
    var hausnummerPassed = ""
    var ortPassed = ""
    var websitePassed = ""
    var beschreibungPassed = ""
    var longitude = NSNumber()
    var latitude = NSNumber()

    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        let url = URL(string: "http://localhost:8888/upload.php")!
        
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
        let author = UserDefaults.standard.string(forKey: "username")!
            let lat:String = String(format:"%f", latitude.doubleValue)
        let lon:String = String(format:"%f", longitude.doubleValue)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let params = [
            "name": namePassed,
            "kategorie": kategoriePassed,
            "preis": preisPassed,
            "datum": datumPassed,
            "beschreibung": beschreibungPassed,
            "longitude": lon,
            "latitude": lat,
            "strasse": strassePassed,
            "hausnummer": hausnummerPassed,
            "ort": ortPassed,
            "author": author,
            "website": websitePassed
            ]
        
        let postString = "img=\(img)&name=\(namePassed)&kategorie=\(kategoriePassed)&preis=\(preisPassed)&datum=\(datumPassed)&strasse=\(strassePassed)&hausnummer=\(hausnummerPassed)&ort=\(ortPassed)&website=\(websitePassed)&beschreibung=\(beschreibungPassed)&latitude=\(lat)&longitude=\(lon)&author=\(author)"
        request.httpBody = createBody(parameters: params,
                                boundary: boundary,
                                data: UIImageJPEGRepresentation(ImageView.image!, 1)!,
                                mimeType: "image/jpg",
                                filename: "hello.jpg")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("response =\(String(describing: response))")
            
                if error != nil
                {
                    print("error=\(String(describing: error))")
                    return
                }
            }
            task.resume()
            ImageView.image = nil
        
        }
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
        
    }
    
    }
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
}

}
