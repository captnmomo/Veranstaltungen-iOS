//
//  LoginViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 28.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var login: UIButton!
    
    let defaultValues = UserDefaults.standard
    
    @IBAction func loginButton(_ sender: Any) {
        
        let user = textUser.text!
        let password = textPassword.text!
        
        let URL_USER_LOGIN = "https://gauss.wi.hm.edu/Veranstaltungen/Login.php?user=" + user + "&password=" + password;
        print(URL_USER_LOGIN)
        let url: URL = URL(string: URL_USER_LOGIN)!
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
            
        if let uname = jsonElement["user"] as? String,
            let userrole = jsonElement["userrole"] as? String,
            let firstname = jsonElement["firstname"] as? String,
            let lastname = jsonElement["lastname"] as? String,
            let email = jsonElement["email"] as? String
        {
            self.defaultValues.set(uname, forKey: "username")
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
                self.errorLabel.text = "Falscher Username oder Passwort"
            }
        }
            
    }
    }
    

    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textUser: UITextField!
    
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        
        setDoneOnKeyboard()
        
        errorLabel.text = ""
        
        super.viewDidLoad()
        
        if let rootVC = navigationController?.viewControllers.first {
            navigationController?.viewControllers = [rootVC, self]
        }


        
        if defaultValues.string(forKey: "username") != nil{
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
            
        }
        
        
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
        self.textUser.inputAccessoryView = keyboardToolbar
        self.textPassword.inputAccessoryView = keyboardToolbar
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
