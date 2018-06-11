//
//  RegisterViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 28.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textFirst: UITextField!
    @IBOutlet weak var textLast: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    let defaultValues = UserDefaults.standard
    
    
    
    @IBAction func register(_ sender: Any) {
        let user = textUser.text!
        let firstname = textFirst.text!
        let lastname = textLast.text!
        let password = textPassword.text!
        let email = textEmail.text!
        
        if(textUser.text?.isEmpty == false && textFirst.text?.isEmpty == false && textLast.text?.isEmpty == false && textPassword.text?.isEmpty == false && textEmail.text?.isEmpty == false){
        
        let URL_USER_REGISTER = "http://localhost:8888/registration.php?user=" + user + "&password=" + password + "&firstname=" + firstname + "&lastname=" + lastname + "&email=" + email;
        print(URL_USER_REGISTER)
        let url: URL = URL(string: URL_USER_REGISTER)!
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
        } else{
            errorLabel.text = "Alle Felder ausfüllen!"
        }
        
        
    }
    
    func parseJSON(_ data:Data){
        var jsonResult = NSArray()
        do{jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        var jsonElement = NSDictionary()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let uname = jsonElement["user"] as? String
            {
                let user = textUser.text!
                let firstname = textFirst.text!
                let lastname = textLast.text!
                let email = textEmail.text!
                let userrole = "user"
                
                self.defaultValues.set(user, forKey: "username")
                self.defaultValues.set(userrole, forKey: "userrole")
                self.defaultValues.set(firstname, forKey: "firstname")
                self.defaultValues.set(lastname, forKey: "lastname")
                self.defaultValues.set(email, forKey: "email")
                DispatchQueue.main.async{
                    let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    self.navigationController?.pushViewController(profileViewController, animated: true)
                    
                    self.dismiss(animated: false, completion: nil)
                }
            }else {
                DispatchQueue.main.async{
                    self.errorLabel.text = "Username schon vergeben!"
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        
        setDoneOnKeyboard()
        
        super.viewDidLoad()
        
        errorLabel.text = ""

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
