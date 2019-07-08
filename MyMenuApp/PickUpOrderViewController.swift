//
//  PickUpOrderViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse
import RealmSwift
import UserNotifications

class PickUpOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pickupItem:PFObject?
    var listOfOrder:Results<OrderItem>?
    
    @IBOutlet var pickUpList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Pick Up Order"
        
        let realm = try! Realm()
        
        if(pickupItem != nil){
            let newPickUpItem = OrderItem()
            
            newPickUpItem.itemName = pickupItem?.object(forKey: "name") as! String
            newPickUpItem.itemPrice = pickupItem?.object(forKey: "price") as! String
            newPickUpItem.itemPic = pickupItem?.object(forKey: "imageURL") as! String
            
            try! realm.write {
                realm.add(newPickUpItem)
            }
        }
        
        let item1 = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearList))
        self.navigationItem.rightBarButtonItem = item1
        
        let content = UNMutableNotificationContent()
        content.title = "Ready"
        content.body = "Your Order is Ready for Pick up"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "OrderAlarm", content: content, trigger: trigger)
        
        // Schedule the request.
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    
    @objc func clearList(){
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(listOfOrder!)
        }
        
        pickUpList.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        
        listOfOrder = realm.objects(OrderItem.self)
        pickUpList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfOrder!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let theOrder = self.listOfOrder![indexPath.row]
        
        cell?.textLabel?.text = theOrder.itemName as! String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pickUpList.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailOrder", sender: self.listOfOrder?[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailOrder"){
            let destinationView = segue.destination as! FavOrderViewController
            
            destinationView.myOrder = sender as? OrderItem
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
