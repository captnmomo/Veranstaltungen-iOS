//
//  RegisterViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 28.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textFirst: UITextField!
    @IBOutlet weak var textLast: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    let URL_REGISTRATION = "http://localhost:8080/Veranstaltungen/registration.php"
    
    @IBAction func register(_ sender: Any) {
        let requestURL = NSURL(string: URL_REGISTRATION)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL )
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let user=textUser.text
        let firstname = textFirst.text
        let lastname = textLast.text
        let email = textEmail.text
        let password = textPassword.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "user="+user!+"&firstname="+firstname!+"&lastname="+lastname!+"&email="+email!+"&password="+password!;
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
    }
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        
        setDoneOnKeyboard()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(FirstViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.textPassword.inputAccessoryView = keyboardToolbar
        self.textUser.inputAccessoryView = keyboardToolbar
        self.textLast.inputAccessoryView = keyboardToolbar
        self.textFirst.inputAccessoryView = keyboardToolbar
        self.textEmail.inputAccessoryView = keyboardToolbar
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
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
