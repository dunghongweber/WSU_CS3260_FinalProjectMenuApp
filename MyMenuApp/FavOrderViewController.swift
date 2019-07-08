//
//  FavOrderViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import RealmSwift
import Parse

class FavOrderViewController: UIViewController {

    @IBOutlet var imageViewItem: UIImageView!
    
    @IBOutlet var priceTxtFldOrder: UITextField!
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var descriptionTxtFld: UITextView!
    
    var myFavorite:FavorItem? = nil
    var myOrder:OrderItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(myFavorite != nil){
            self.title = myFavorite?.itemName
            self.priceTxtFldOrder.text = myFavorite?.itemPrice
            self.descriptionTxtFld.text = myFavorite?.itemDescription
            let url = URL(string: (myFavorite?.itemPic)!)
            let data = NSData(contentsOf: url!)
            
            self.imageViewItem.image = UIImage(data: data! as Data)// Error here
            
        }
        if(myOrder != nil){
            self.descriptionLabel.isHidden = true
            self.descriptionTxtFld.isHidden = true
            
            self.title = myOrder?.itemName
            self.priceTxtFldOrder.text = myOrder?.itemPrice
            
            let url = URL(string: (myOrder?.itemPic)!)
            let data = NSData(contentsOf: url!)
            
            self.imageViewItem.image = UIImage(data: data! as Data)// Error here
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
