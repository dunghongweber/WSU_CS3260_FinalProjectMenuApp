//
//  NotificationViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class NotificationViewController: UIViewController {
    
    var myNotification:PFObject?
    
    @IBOutlet var notificationTxtArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification"

        if((PFUser.current()?.username) == "admin"){
            let item1 = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editNoti))
            self.navigationItem.rightBarButtonItem = item1
        }
    }
    
    @objc func editNoti() {
        performSegue(withIdentifier: "editNotification", sender: myNotification)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editNotification") {
            let destinationViewController = segue.destination as! EditNotificationViewController
            
            destinationViewController.myEditNoti = myNotification
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Retrieve objects
        let query = PFQuery(className:"Notification")
        query.whereKey("appName", equalTo: "menuApp")
        query.findObjectsInBackground { (objects, error) in
            if error == nil  {
                print("Ok found")
                for object in objects! {
                    self.myNotification = object
                    
                    self.notificationTxtArea.text = self.myNotification?.object(forKey: "note") as! String
                }
            } else {
                print(error)
            }
            
            
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
