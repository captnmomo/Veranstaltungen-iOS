//
//  MoreViewController.swift
//  Veranstaltungen iOS
//
//  Created by momo on 06.06.18.
//  Copyright © 2018 SE1. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    let defaultValues = UserDefaults.standard

    @IBAction func Login(_ sender: Any) {
        if defaultValues.string(forKey: "username") != nil{
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
            
        }else{
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "testzahl")
        UserDefaults.standard.removeObject(forKey: "username")
        
        let alert = UIAlertController(title: "Done", message: "Alle Daten wurden gelöscht", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    override func viewDidLoad() {
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        let tabBarController: UITabBarController?
        
        self.tabBarController?.selectedIndex = 3;
        
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
