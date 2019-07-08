//
//  LocationViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import Foundation

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTable: UITableView!
    
    var locationList:[PFObject] = []
    
    var myLocation:PFObject?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locations"
        
        if(PFUser.current()?.username == "admin"){
            
            let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
            self.navigationItem.rightBarButtonItem = item
        }
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self as? CLLocationManagerDelegate
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Retrieve objects
        locationList.removeAll()
        let query = PFQuery(className:"LocationItem")
        query.whereKey("appName", equalTo: "menuApp")
        query.findObjectsInBackground { (objects, error) in
            if error == nil  {
                print("Ok found")
                for object in objects! {
                    self.locationList.append(object)
                }
                self.myTable.reloadData()
            } else {
                print(error)
            }
            self.myTable.reloadData()
        }
//        for location in locationList{
//            let geoCoder = CLGeocoder()
//            geoCoder.geocodeAddressString(location.object(forKey: "address") as! String) { (placemark, error) in
//
//                let placemarks = placemark?.first
//                let lat = placemarks?.location?.coordinate.latitude
//                let lon = placemarks?.location?.coordinate.longitude
//                print("Lat:\(lat), Lon: \(lon)")
//        }
    }
    
    @objc func addLocation() {
        performSegue(withIdentifier: "addLocation", sender: myLocation)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let theLocation = self.locationList[indexPath.row]
        
        cell?.textLabel?.text = theLocation["name"] as! String
        cell?.textLabel?.textAlignment = .center
        
        cell?.textLabel?.backgroundColor = UIColor.brown
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "locationDetail", sender: locationList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "locationDetail"){
            let destinationViewController = segue.destination as! LocationDetailViewController
            
            destinationViewController.myLcoation = sender as! PFObject
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
