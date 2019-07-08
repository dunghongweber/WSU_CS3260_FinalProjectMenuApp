//
//  ViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 3/20/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet var usernameTxtFld: UITextField!
    
    @IBOutlet var passwordTxtFld: UITextField!
    
    @IBOutlet var logInBtn: UIButton!
    
    @IBOutlet var skipBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        logInBtn.layer.cornerRadius = 15
        logInBtn.layer.borderWidth = 1
        logInBtn.layer.borderColor = UIColor.brown.cgColor
        
        skipBtn.layer.cornerRadius = 15
        skipBtn.layer.borderWidth = 1
        skipBtn.layer.borderColor = UIColor.brown.cgColor
    }

    @IBAction func logInBtnClicked(_ sender: UIButton) {
        //Login
        PFUser.logInWithUsername(inBackground: usernameTxtFld.text!, password: passwordTxtFld.text!) { (user, error) in
            if error == nil  {
                print(user?.username)
                print(user?.password)
                self.performSegue(withIdentifier: "ShowMenu", sender: user)
            } else {
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                    (alert: UIAlertAction!) in
                    self.performSegue(withIdentifier: "SignUpAccount", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func skipBtnClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShowMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowMenu"){
            let destinationView = segue.destination as! MainAppearanceViewController
            
            destinationView.myUser = sender as? PFUser
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

