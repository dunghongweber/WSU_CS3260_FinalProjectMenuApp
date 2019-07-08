//
//  SignUpViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/16/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet var usernameTxtFld: UITextField!
    
    @IBOutlet var passwordTxtFld: UITextField!
    
    @IBOutlet var emailTxtFld: UITextField!
    
    @IBOutlet var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBtn.layer.cornerRadius = 15
        signUpBtn.layer.borderWidth = 1
        signUpBtn.layer.borderColor = UIColor.brown.cgColor
    }
    
    @IBAction func signUpBtnCLicked(_ sender: UIButton) {
        //        Signing up
        let user = PFUser()
        user.email = self.emailTxtFld.text
        user.username = self.usernameTxtFld.text
        user.password = self.passwordTxtFld.text
        
        user.signUpInBackground { (success, error) in
            if (error == nil) {
                print("I signed up")
                self.performSegue(withIdentifier: "SignUpSuccess", sender: user)
            } else {
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SignUpSuccess"){
            let SVC = segue.destination as! MainAppearanceViewController
            SVC.myUser = sender as? PFUser
        }
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
