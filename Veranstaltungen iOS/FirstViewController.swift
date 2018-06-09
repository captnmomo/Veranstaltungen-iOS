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

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    let defaultValues = UserDefaults.standard
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
        if defaultValues.integer(forKey: "testzahl") != nil {
            print("TestSerach")
            print(defaultValues.integer(forKey: "testzahl"))
            var i = defaultValues.integer(forKey: "testzahl")
            let iString = String(i)
            i = i + 1
            defaultValues.set(i, forKey: "testzahl")
            let DefaultString = "Array" + iString
            let array : [String: String] = ["Preis1": textPreis1.text!, "Preis2": textPreis2.text!, "Kategorie": textKategorie.text!, "Umkreis": textUmkreis.text!]
            print ("TestSearch: " + array["Preis1"]!)
            defaultValues.set(array,forKey: DefaultString)
        }
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
    
    @IBOutlet weak var searchedTableView: UITableView!
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
        
        self.searchedTableView.delegate = self
        self.searchedTableView.dataSource = self
        
        
        searchedTableView.reloadData()
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchedTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        print(defaultValues.integer(forKey: "testzahl"))
       return defaultValues.integer(forKey: "testzahl")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        print("test")
        let cellIdentifier: String = "searchedCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let arrayInteger = defaultValues.integer(forKey: "testzahl")
        let countRow = arrayInteger - indexPath.row - 1
        let countString = String(countRow)
        let arraystring = "Array" + countString
        print(arraystring)
        let readArray = defaultValues.value(forKey: arraystring)! as! NSDictionary
        let kategorie = readArray["Kategorie"] as? String
        let Umkreis = readArray["Umkreis"] as? String
        let Preis1 = readArray["Preis1"] as? String
        let Preis2 = readArray["Preis2"] as? String
        print("test: " + Preis2!)
        let itemData = kategorie! + ", " + Umkreis! + ", " + Preis1! + "€ bis " + Preis2! + "€"
        myCell.textLabel!.text = itemData
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countString = String(indexPath.row)
        let arraystring = "Array" + countString
        let readArray = defaultValues.value(forKey: arraystring)! as! NSDictionary
        let myVC = storyboard?.instantiateViewController(withIdentifier: "TableView") as! TableViewController
        myVC.preis1passed = (readArray["Preis1"] as? String)!
        myVC.preis2passed = (readArray["Preis2"] as? String)!
        myVC.kategoriepassed = (readArray["Kategorie"] as? String)!
        myVC.umkreispassed = (readArray["Umkreis"] as? String)!
        navigationController?.pushViewController(myVC, animated: true)
    }
    }



