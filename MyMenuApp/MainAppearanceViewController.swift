//
//  MainAppearanceViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/16/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse

class MainAppearanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuChoices:[String] = []
    
    @IBOutlet var listOfChoices: UITableView!
    
    var myUser:PFUser?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuChoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let theChoice = self.menuChoices[indexPath.row]
        
        cell?.textLabel?.text = theChoice
        cell?.textLabel?.backgroundColor = UIColor.brown
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listOfChoices.deselectRow(at: indexPath, animated: true)
        //show menu when click on 1st row
        if(indexPath.row == 0){
            self.performSegue(withIdentifier: "showRestaurantMenu", sender: myUser)
        }
        if(indexPath.row == 1 && PFUser.current() != nil){
            self.performSegue(withIdentifier: "showPickUpOrder", sender: self)
        }
        if(indexPath.row == 2 && PFUser.current() != nil){
            self.performSegue(withIdentifier: "showMyFavorite", sender: self)
        }
        if(indexPath.row == 3 && PFUser.current() != nil){
            self.performSegue(withIdentifier: "showLocation", sender: self)
        }
        if(indexPath.row == 4 && PFUser.current() != nil){
            self.performSegue(withIdentifier: "showNotification", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurant's App"
        
        self.menuChoices.append("Menu")
        self.menuChoices.append("My Pickup Order")
        self.menuChoices.append("My Favorites")
        self.menuChoices.append("Restaurant Locations")
        self.menuChoices.append("Notification")
        
        print(myUser)
        
        if(((myUser)) != nil){
            let item1 = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut))
            
            self.navigationItem.leftBarButtonItem = item1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if((myUser) != nil){
            self.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    
    @objc func logOut(){
        //        Logging out
        PFUser.logOutInBackground { (error) in
            if error == nil {
                print("i logged out")
            }
        }
        performSegue(withIdentifier: "LogOut", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
