//
//  SecondViewController.swift
//  Safe Travel
//
//  Created by Medha Gupta on 9/5/17.
//  Copyright © 2017 Medha Gupta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SecondViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet var addressField: UITextField!
    @IBOutlet var hoursField: UITextField!
    @IBOutlet var minutes: UITextField!
    @IBOutlet var rangeField: UITextField!
    @IBOutlet var nextButton: UIBarButtonItem!
    
    var locationManager = CLLocationManager()
    
    @IBAction func saveTwo(_ sender: Any) {
        UserDefaults.standard.set(addressField.text, forKey: "address")
    
        UserDefaults.standard.set(hoursField.text, forKey: "hours")
        
        UserDefaults.standard.set(minutes.text, forKey: "minutes")
        
        UserDefaults.standard.set(rangeField.text, forKey: "range")
        
        self.displayValues()
        
        nextButton.isEnabled = true
    }
    
    func displayValues()
    {
        let adrsObject = UserDefaults.standard.object(forKey: "address")
        if let address = adrsObject as? String {
            addressField.text = address
        }
        
        let hrsObject = UserDefaults.standard.integer(forKey: "hours")
        if let hours = hrsObject as? Int {
            hoursField.text = String(hours)
        }
        
        let minObject = UserDefaults.standard.integer(forKey: "minutes")
        if let min = minObject as? Int {
            minutes.text = String(min)
        }
        
        let rangeObject = UserDefaults.standard.integer(forKey: "range")
        if let range = rangeObject as? Int {
            rangeField.text = String(range)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayValues()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let userLocation: CLLocation = locations[0]
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                if let placemark = placemarks?[0]
                {
                    var subThoroughfare = ""
                    
                    if placemark.subThoroughfare != nil
                    {
                        subThoroughfare = placemark.subThoroughfare!
                    }
                    
                    var thoroughfare = ""
                    
                    if placemark.thoroughfare != nil
                    {
                        thoroughfare = placemark.thoroughfare!
                    }
                    
                    var subLocality = ""
                    
                    if placemark.subLocality != nil
                    {
                        subLocality = placemark.subLocality!
                    }
                    
                    var subAdministrativeArea = ""
                    
                    if placemark.subAdministrativeArea != nil
                    {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    
                    var postCode = ""
                    
                    if placemark.postalCode != nil
                    {
                        postCode = placemark.postalCode!
                    }
                    
                    var country = ""
                    
                    if placemark.country != nil
                    {
                        country = placemark.country!
                    }
                    
                    let initiallocation = subThoroughfare + " " + thoroughfare + " " + subLocality + " " + subAdministrativeArea + ", " + country + " " + postCode
                    
                    UserDefaults.standard.set(initiallocation, forKey: "initiallocation")
                    
                }
            }
            
        }
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
