//
//  ItemDetailViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/16/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class ItemDetailViewController: UIViewController {
    
    
    var detailOfItem:PFObject?
    var viewOnly:Int?
    
    var ratingList:[PFObject] = []
    var myRating = 0.0
    var totalRating = 0.0

    @IBOutlet var imageViewItem: UIImageView!
    
    @IBOutlet var priceTxtFieldItem: UITextField!
    
    @IBOutlet var ratingTxtFldItem: UITextField!
    
    @IBOutlet var codeTxtFld: UITextField!
    
    @IBOutlet var descriptionTxtFldItem: UITextView!
    
    @IBOutlet var addToOrderBtn: UIButton!
    
    @IBOutlet var addToFavoritesBtn: UIButton!
    
    @IBOutlet var rateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToOrderBtn.layer.cornerRadius = 15
        addToOrderBtn.layer.borderWidth = 1
        addToOrderBtn.layer.borderColor = UIColor.brown.cgColor
        
        addToFavoritesBtn.layer.cornerRadius = 15
        addToFavoritesBtn.layer.borderWidth = 1
        addToFavoritesBtn.layer.borderColor = UIColor.brown.cgColor
        
        rateBtn.layer.cornerRadius = 15
        rateBtn.layer.borderWidth = 1
        rateBtn.layer.borderColor = UIColor.brown.cgColor
        
        rateBtn.isHidden = true
        addToOrderBtn.isHidden = true
        addToFavoritesBtn.isHidden = true
        
        if(PFUser.current() != nil){
            rateBtn.isHidden = false
            addToFavoritesBtn.isHidden = false
            addToOrderBtn.isHidden = false
        }
        
        if(PFUser.current()?.username == "admin"){
            
            let item = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editItem))
            self.navigationItem.rightBarButtonItem = item
        }
        
        if(detailOfItem != nil){
            self.title = detailOfItem?.object(forKey: "name") as! String
            
            self.priceTxtFieldItem.text = "$" + (detailOfItem?.object(forKey: "price") as! String)
            
            self.descriptionTxtFldItem.text = detailOfItem?.object(forKey: "description") as! String
            
            self.codeTxtFld.text = detailOfItem?.object(forKey: "code") as! String
            
            let url = URL(string: detailOfItem?.object(forKey: "imageURL") as! String)
            let data = NSData(contentsOf: url!)
            
            self.imageViewItem.image = UIImage(data: data! as Data)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Retrieve objects
        let query = PFQuery(className:"RateItem")
        query.whereKey("code", equalTo: detailOfItem?.object(forKey: "code"))
        query.findObjectsInBackground { (objects, error) in
            if error == nil  {
                print("Ok found")
                for object in objects! {
                    self.ratingList.append(object)
                    self.myRating = self.myRating + Double(object.object(forKey: "rate") as! String)!
                }
            } else {
                print(error)
            }
            self.totalRating = self.myRating/Double(self.ratingList.count);
            self.ratingTxtFldItem.text = String(format:"%.1f / 5" ,self.totalRating)
            
            print(self.totalRating)
            print(self.detailOfItem?.object(forKey: "code"))
        }
    }
    
    @objc func editItem() {
        performSegue(withIdentifier: "editItem", sender: detailOfItem)
    }
    
    
    @IBAction func rateBtnClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "rateItem", sender: detailOfItem)
        
    }
    
    
    @IBAction func addFavoriteClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "addToFavorite", sender: detailOfItem)
    }
    
    
    @IBAction func addToOrderClicked(_ sender: Any) {
        performSegue(withIdentifier: "addToOrder", sender: detailOfItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editItem") {
            let destinationViewController = segue.destination as! ItemEditViewController
            
            destinationViewController.detailOfItem = detailOfItem
        }
        if(segue.identifier == "rateItem"){
            let destinationViewController = segue.destination as! RateItemViewController
            
            destinationViewController.myItem = detailOfItem
        }
        if(segue.identifier == "addToOrder"){
            let destinationViewController = segue.destination as! PickUpOrderViewController
            
            destinationViewController.pickupItem = detailOfItem
        }
        if(segue.identifier == "addToFavorite"){
            let destinationViewController = segue.destination as! MyFavoriteViewController
            
            destinationViewController.myfavItem = detailOfItem
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
