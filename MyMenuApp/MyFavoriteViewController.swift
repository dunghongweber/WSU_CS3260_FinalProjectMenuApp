//
//  MyFavoriteViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse
import RealmSwift

class MyFavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myfavItem:PFObject?
    var listOfItem:Results<FavorItem>?

    @IBOutlet var myTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Favorite Items"
        
        let realm = try! Realm()
        
        if(myfavItem != nil){
            let newFav = FavorItem()
            
            newFav.itemName = myfavItem?.object(forKey: "name") as! String
            newFav.itemPrice = myfavItem?.object(forKey: "price") as! String
            newFav.itemPic = myfavItem?.object(forKey: "imageURL") as! String
            newFav.itemDescription = myfavItem?.object(forKey: "description") as! String
            
            try! realm.write {
                realm.add(newFav)
            }
        }
        
        let item1 = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearList))
        
        self.navigationItem.rightBarButtonItem = item1
    }
    
    @objc func clearList(){
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(listOfItem!)
        }
        
        myTable.reloadData()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        
        listOfItem = realm.objects(FavorItem.self)
        myTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listOfItem?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let theItem = self.listOfItem![indexPath.row]
        
        cell?.textLabel?.text = theItem.itemName as! String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailFavorite", sender: self.listOfItem?[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailFavorite"){
            let destinationView = segue.destination as! FavOrderViewController
            
            destinationView.myFavorite = sender as? FavorItem
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
