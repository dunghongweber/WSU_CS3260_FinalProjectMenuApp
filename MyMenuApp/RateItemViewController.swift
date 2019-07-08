//
//  RateItemViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class RateItemViewController: UIViewController {
    
    var myItem:PFObject?

    @IBOutlet var imageViewRate: UIImageView!
    
    @IBOutlet var codeTxtFldRate: UITextField!
    
    @IBOutlet var ratingTxtFld: UITextField!
    
    @IBOutlet var stepperRating: UIStepper!
    
    
    @IBOutlet var rateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ratingTxtFld.text = String(format:"%.1f",stepperRating.minimumValue)
        
        if(myItem != nil){
            self.title = (myItem?.object(forKey: "name") as! String)+" Rating"
            
            self.codeTxtFldRate.text = myItem?.object(forKey: "code") as! String
        
            let url = URL(string: myItem?.object(forKey: "imageURL") as! String)
            let data = NSData(contentsOf: url!)
            
            self.imageViewRate.image = UIImage(data: data! as Data)
        
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        
        self.ratingTxtFld.text = String(self.stepperRating.value)
    }
    
    
    @IBAction func rateItemClicked(_ sender: UIButton) {
        if(myItem != nil){
            let theRating = PFObject(className:"RateItem")
            theRating["code"] = self.codeTxtFldRate.text
            theRating["rate"] = self.ratingTxtFld.text
            
            theRating.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    // The object has been saved.
                    print("created rating object")
                    print(theRating)
                } else {
                    // There was a problem, check error.description
                    print(error)
                }
            }
        }
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
