//
//  ItemEditViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class ItemEditViewController: UIViewController {
    
    var detailOfItem:PFObject?

    @IBOutlet var nameTxtFld: UITextField!
    
    @IBOutlet var priceTxtFld: UITextField!
    
    @IBOutlet var imageURLTxtFld: UITextField!
    
    @IBOutlet var categoryTxtFld: UITextField!
    
    @IBOutlet var descriptionTxtFld: UITextView!
    
    @IBOutlet var codeTxtFld: UITextField!
    
    @IBOutlet var editAddBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if(detailOfItem != nil){
            self.nameTxtFld.text = detailOfItem?.object(forKey: "name") as! String
            self.priceTxtFld.text = detailOfItem?.object(forKey: "price") as! String
            self.imageURLTxtFld.text = detailOfItem?.object(forKey: "imageURL") as! String
            self.categoryTxtFld.text = detailOfItem?.object(forKey: "idCategory") as! String
            self.descriptionTxtFld.text = detailOfItem?.object(forKey: "description") as! String
            self.codeTxtFld.text = detailOfItem?.object(forKey: "code") as! String
            
            print(detailOfItem!["idCategory"])
        }
        
        editAddBtn.layer.cornerRadius = 15
        editAddBtn.layer.borderWidth = 1
        editAddBtn.layer.borderColor = UIColor.black.cgColor
        
        deleteBtn.layer.cornerRadius = 15
        deleteBtn.layer.borderWidth = 1
        deleteBtn.layer.borderColor = UIColor.brown.cgColor
    }

    @IBAction func editAddBtnClicked(_ sender: UIButton) {
        //Creating new Name Object
        if(detailOfItem == nil){
            let theItem = PFObject(className:"ItemDish")
            theItem["name"] = self.nameTxtFld.text
            theItem["price"] = self.priceTxtFld.text
            theItem["idCategory"] = self.categoryTxtFld.text
            theItem["imageURL"] = self.imageURLTxtFld.text
            theItem["description"] = self.descriptionTxtFld.text
            theItem["code"] = self.codeTxtFld.text
            
            theItem.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    // The object has been saved.
                    print("created object")
                    print(theItem)
                } else {
                    // There was a problem, check error.description
                    print(error)
                }
            }
        } else{
            //editing item
            detailOfItem!["name"] = self.nameTxtFld.text
            detailOfItem!["price"] = self.priceTxtFld.text
            
            detailOfItem!["idCategory"] = self.categoryTxtFld.text
            
            detailOfItem!["imageURL"] = self.imageURLTxtFld.text
            detailOfItem!["description"] = self.descriptionTxtFld.text
            detailOfItem!["code"] = self.codeTxtFld.text
            
            detailOfItem?.saveInBackground(block: { (success, error) in
                if (success) {
                    // The object has been saved.
                    print("saved object")
                    print(self.detailOfItem)
                    
                } else {
                    // There was a problem, check error.description
                    print(error)
                }
            })
        }
    }
    
    @IBAction func deleteBtnClicked(_ sender: UIButton) {
        if(detailOfItem != nil){
            detailOfItem?.deleteEventually()
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
