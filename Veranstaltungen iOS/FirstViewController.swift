//
//  FirstViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 23.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 2){
        return kategoriePickerData.count
        }
        else{
            return umkreisPickerData.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 2){
        return kategoriePickerData[row]
        }
        else{
            return umkreisPickerData[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 2){
        textKategorie.text = kategoriePickerData[row]
        }
        else{
            textUmkreis.text = umkreisPickerData[row]
        }
    }
    
    @IBAction func suchen(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "TableView") as! TableViewController
        myVC.preis1passed = textPreis1.text!
        myVC.preis2passed = textPreis2.text!
        myVC.kategoriepassed = textKategorie.text!
        myVC.umkreispassed = textUmkreis.text!
        navigationController?.pushViewController(myVC, animated: true)
    }
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(FirstViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.textKategorie.inputAccessoryView = keyboardToolbar
        self.textUmkreis.inputAccessoryView = keyboardToolbar
        self.textPreis1.inputAccessoryView = keyboardToolbar
        self.textPreis2.inputAccessoryView = keyboardToolbar
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var showcase: UIImageView!
    
    let kategoriePickerData = [String](arrayLiteral: "Party", "Natur", "Familie", "Jugend")
    let umkreisPickerData = [String](arrayLiteral: "10km", "30km", "50km", "100km", ">100km")
    @IBOutlet weak var textKategorie: UITextField!
    @IBOutlet weak var textUmkreis: UITextField!
    @IBOutlet weak var textPreis1: UITextField!
    @IBOutlet weak var textPreis2: UITextField!
    override func viewDidLoad() {
        let pickerUmkreis = UIPickerView()
        let pickerKategorie = UIPickerView()
        
        pickerUmkreis.tag = 1
        pickerKategorie.tag = 2
        
        textKategorie.inputView = pickerKategorie
        textUmkreis.inputView = pickerUmkreis
        
        pickerKategorie.delegate = self
        pickerUmkreis.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        setDoneOnKeyboard()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

