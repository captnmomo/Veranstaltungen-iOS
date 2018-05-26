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
    
    let kategoriePickerData = [String](arrayLiteral: "Party", "Natur", "Familie", "Jugend")
    let umkreisPickerData = [String](arrayLiteral: "10km", "30km", "50km", "100km", ">100km")
    @IBOutlet weak var textKategorie: UITextField!
    @IBOutlet weak var textUmkreis: UITextField!
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
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

