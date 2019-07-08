//
//  LocationDetailViewController.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class LocationDetailViewController: UIViewController {
    
    var myLcoation:PFObject?

    @IBOutlet var locationName: UITextField!
    
    @IBOutlet var locationAddress: UITextField!
    
    @IBOutlet var loctionPhone: UITextField!
    
    @IBOutlet var mapViewLocation: MKMapView!
    
    @IBOutlet var callBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = myLcoation?.object(forKey: "name") as! String
        
        callBtn.layer.cornerRadius = 15
        callBtn.layer.borderWidth = 1
        callBtn.layer.borderColor = UIColor.black.cgColor
        if(myLcoation != nil){
            self.locationName.text = myLcoation?.object(forKey: "name") as! String
            self.locationAddress.text = myLcoation?.object(forKey: "address") as! String
            self.loctionPhone.text = myLcoation?.object(forKey: "phone") as! String
            
            
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(myLcoation?.object(forKey: "address") as! String) { (placemark, error) in
                    let placemarks = placemark?.first
                let lat = placemarks?.location?.coordinate.latitude
                let lon = placemarks?.location?.coordinate.longitude
                    print("Lat:\(lat), Lon: \(lon)")
                
                // set initial location in Honolulu
                let initialLocation = CLLocation(latitude: lat!, longitude: lon!)
                // set initial location in Honolulu
                let regionRadius: CLLocationDistance = 1000
                func centerMapOnLocation(location: CLLocation) {
                    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                              regionRadius, regionRadius)
                    self.mapViewLocation.setRegion(coordinateRegion, animated: true)
                }
                
                centerMapOnLocation(location: initialLocation)
                let artwork = Artwork(locationName: self.myLcoation?.object(forKey: "name") as! String ,coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: lon!))
                
                self.mapViewLocation.addAnnotation(artwork)
            }
        }

        if(PFUser.current()?.username == "admin"){
            
            let item = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editLocation))
            self.navigationItem.rightBarButtonItem = item
        }
        
        
    }
    
    @objc func editLocation() {
        performSegue(withIdentifier: "editLocation", sender: myLcoation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editLocation"){
            let destinationViewController = segue.destination as! LocationEditAddViewController
            
            destinationViewController.myEditLocation = sender as! PFObject
        }
    }
    
    @IBAction func callBtnClicked(_ sender: UIButton) {
        let phone:String = (myLcoation?.object(forKey: "phone"))! as! String
        
        if let phoneCallURL = URL(string: "tel://\(phone)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }else{
            print("Cannot make phone call")
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
