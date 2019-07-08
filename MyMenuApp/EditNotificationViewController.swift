//
//  EditNotificationViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class EditNotificationViewController: UIViewController {

    @IBOutlet var noteTxtFld: UITextView!
    
    @IBOutlet var deleteBtn: UIButton!
    
    
    @IBOutlet var editAddBtn: UIButton!
    
    var myEditNoti:PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(myEditNoti != nil){
            self.noteTxtFld.text = self.myEditNoti?.object(forKey: "note") as! String
        }
        editAddBtn.layer.cornerRadius = 15
        editAddBtn.layer.borderWidth = 1
        editAddBtn.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func editAddBtnClicked(_ sender: UIButton) {
        
        //Creating new Name Object
        if(myEditNoti == nil){
            let theNoti = PFObject(className:"Notification")
            theNoti["appName"] = "menuApp"
            theNoti["note"] = self.noteTxtFld.text
            
            theNoti.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    // The object has been saved.
                    print("created notification")
                    print(theNoti)
                } else {
                    // There was a problem, check error.description
                    print(error)
                }
            }
        } else{
            //editing item
            myEditNoti!["appName"] = "menuApp"
            myEditNoti!["note"] = self.noteTxtFld.text
            
            myEditNoti?.saveInBackground(block: { (success, error) in
                if (success) {
                    // The object has been saved.
                    print("saved notification")
                    print(self.myEditNoti)
                    
                } else {
                    // There was a problem, check error.description
                    print(error)
                }
            })
        }
        
    }
    
    
    @IBAction func deleteBtnCLicked(_ sender: UIButton) {
        if(myEditNoti != nil){
            myEditNoti?.deleteEventually()
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
