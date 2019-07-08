//
//  CategoriesViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/16/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var itemsInCategory: UITableView!
    
    var infoOfCategory = [String:Any]()
    var itemList:[PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = infoOfCategory["name"] as! String
        
        print(infoOfCategory["user"])
        
        if((PFUser.current()?.username) == "admin"){
            let item1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
            self.navigationItem.rightBarButtonItem = item1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let idCategoryInt = infoOfCategory["idCategory"] as! Int
        var myStringID = String(idCategoryInt)
        print(myStringID)
        
        self.itemList.removeAll()
        
        //Retrieve objects
        let query = PFQuery(className:"ItemDish")
        query.whereKey("idCategory", equalTo: myStringID)
        query.findObjectsInBackground { (objects, error) in
            if error == nil  {
                print("Ok found")
                for object in objects! {
                    self.itemList.append(object)
                }
                self.itemsInCategory.reloadData()
            } else {
                print(error)
            }
        }
        self.itemsInCategory.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let theName = self.itemList[indexPath.row]
        
        cell?.textLabel?.text = theName.object(forKey: "name") as! String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showItemFromCategory", sender: self.itemList[indexPath.row])
    }
    
    @objc func addItem(){
        performSegue(withIdentifier: "addItem", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="addItem"){
            let addNewItem = segue.destination as! ItemEditViewController
            addNewItem.detailOfItem = sender as? PFObject
        }
        if(segue.identifier == "showItemFromCategory"){
            let showItemDetail = segue.destination as! ItemDetailViewController
            showItemDetail.detailOfItem = sender as! PFObject
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
