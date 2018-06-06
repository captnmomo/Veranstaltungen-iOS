//
//  ErstellenViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 27.05.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class ErstellenViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var ort: UITextField!
    @IBOutlet weak var hausnummer: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var beschreibung: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var kategorie: UITextField!
    @IBOutlet weak var preis: UITextField!
    @IBOutlet weak var datum: UITextField!
    @IBOutlet weak var strasse: UITextField!
    @IBOutlet weak var webiste: UITextField!
    
    let pickerDatum = UIDatePicker()
    
    let kategoriePickerData = [String](arrayLiteral: "Party", "Natur", "Familie", "Jugend")
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(FirstViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.kategorie.inputAccessoryView = keyboardToolbar
        self.name.inputAccessoryView = keyboardToolbar
        self.preis.inputAccessoryView = keyboardToolbar
        self.datum.inputAccessoryView = keyboardToolbar
        self.strasse.inputAccessoryView = keyboardToolbar
        self.hausnummer.inputAccessoryView = keyboardToolbar
        self.ort.inputAccessoryView = keyboardToolbar
        self.webiste.inputAccessoryView = keyboardToolbar
        self.beschreibung.inputAccessoryView = keyboardToolbar
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func datePicker(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ErstellenViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        
        dateFormatter.timeStyle = .none
        
        datum.text = dateFormatter.string(from: sender.date)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return kategoriePickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return kategoriePickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    kategorie.text = kategoriePickerData[row]
    }
    
    override func viewDidLoad() {
        
        let pickerKategorie = UIPickerView()
        
        kategorie.tag = 2
        
        kategorie.inputView = pickerKategorie
        
        pickerKategorie.delegate = self
       
        beschreibung.textAlignment = .left
        beschreibung.contentVerticalAlignment = .top
        
        self.hideKeyboardWhenTappedAround()
        
        setDoneOnKeyboard()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
