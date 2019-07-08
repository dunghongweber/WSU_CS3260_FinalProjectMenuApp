//
//  MenuRestaurantViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/16/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class MenuRestaurantViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableViewCategories: UITableView!
    
    var myUser:PFUser?
    var itemCatagories = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MENU"
        
        if let path = Bundle.main.path(forResource: "Property List", ofType: "plist") {
            //If your plist contain root as Array
            if let contentOfPlist = NSArray.init(contentsOfFile: path) {
                itemCatagories = contentOfPlist as! [[String:Any]]
                tableViewCategories.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCatagories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        //check if there is a cell
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        //create an object
        let object = itemCatagories[indexPath.row]
        
        cell?.textLabel?.text = (object["name"] as! String)
        
        cell?.textLabel?.textAlignment = .center
        
        let url = URL(string: object["image"] as! String)
        let data = NSData(contentsOf: url!)
        
        cell?.imageView?.image = UIImage(data: data! as Data)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var infoEachCategory = [String: Any]()
        
        infoEachCategory.updateValue(indexPath.row, forKey: "idCategory")
        infoEachCategory.updateValue(itemCatagories[indexPath.row]["name"], forKey: "name")
        
        self.performSegue(withIdentifier: "showCategory", sender: infoEachCategory)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCategory"){
            let destinationView = segue.destination as! CategoriesViewController
            
            destinationView.infoOfCategory = sender as! [String: Any]
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
