//
//  LocationEditAddViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class LocationEditAddViewController: UIViewController {

    @IBOutlet var deleteBtn: UIButton!
    
    @IBOutlet var editAddBtn: UIButton!
    
    @IBOutlet var nameTxtFld: UITextField!
    
    @IBOutlet var addressTxtFld: UITextField!
    
    @IBOutlet var phoneTxtFld: UITextField!
    
    var myEditLocation:PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Location"
        
        editAddBtn.layer.cornerRadius = 15
        editAddBtn.layer.borderWidth = 1
        editAddBtn.layer.borderColor = UIColor.black.cgColor
        
        deleteBtn.layer.cornerRadius = 15
        deleteBtn.layer.borderWidth = 1
        deleteBtn.layer.borderColor = UIColor.black.cgColor
        
        if(myEditLocation != nil){
            self.nameTxtFld.text = myEditLocation?.object(forKey: "name") as! String
            self.addressTxtFld.text = myEditLocation?.object(forKey: "address") as! String
            self.phoneTxtFld.text = myEditLocation?.object(forKey: "phone") as! String
        }
    }

    @IBAction func addEditBtnClicked(_ sender: UIButton) {
        //Creating new Name Object
        if(myEditLocation == nil){
            let theLocation = PFObject(className:"LocationItem")
            theLocation["name"] = self.nameTxtFld.text
            theLocation["address"] = self.addressTxtFld.text
            theLocation["phone"] = self.phoneTxtFld.text
            theLocation["appName"] = "menuApp"
            
            theLocation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    // The object has been saved.
                    print("created location")
                    print(theLocation)
                } else {
                    // There was a problem, check error.description
                    print(error)
                }
            }
        } else{
            //editing item
            myEditLocation!["name"] = self.nameTxtFld.text
            myEditLocation!["addres"] = self.addressTxtFld.text
            myEditLocation!["phone"] = self.phoneTxtFld.text
            myEditLocation!["appName"] = "menu"
            
           myEditLocation?.saveInBackground(block: { (success, error) in
                if (success) {
                    // The object has been saved.
                    print("saved object")
                    print(self.myEditLocation)
                    
                } else {
                    // There was a problem, check error.description
                    print(error)
                }
            })
        }
    }
    
    
    @IBAction func deleteBtnClicked(_ sender: UIButton) {
        myEditLocation?.deleteEventually()
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
