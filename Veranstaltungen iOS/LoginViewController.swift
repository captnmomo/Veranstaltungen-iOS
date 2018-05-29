//
//  LoginViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 28.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textUser: UITextField!
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
