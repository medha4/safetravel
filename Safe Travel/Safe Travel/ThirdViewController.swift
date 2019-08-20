//
//  ThirdViewController.swift
//  Safe Travel
//
//  Created by Medha Gupta on 9/5/17.
//  Copyright © 2017 Medha Gupta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ThirdViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var plusfive: UIButton!
    @IBOutlet var changebutton: UIButton!
    @IBOutlet var minusfive: UIButton!
    
    var locationManager = CLLocationManager()
    
    var timer = Timer()
    
    var time = 10
    
    var isStarted = false
    
    let hrs = UserDefaults.standard.integer(forKey: "hours")
    
    let mins = UserDefaults.standard.integer(forKey: "minutes")
    
    let range = UserDefaults.standard.integer(forKey: "range")
    
    var hoursLabel = 0
    var minutesLabel = 0
    var secondsLabel = 0

    func decrease()
    {
        if time > 0
        {
            time -= 1
            
            self.hoursLabel = Int(time) / 3600
            
            self.minutesLabel = Int(time) / 60 % 60
            
            self.secondsLabel = Int(time) % 60
            
            timeLabel.text = String(self.hoursLabel) + " hours : " + String(self.minutesLabel) + " minutes : " + String(self.secondsLabel) + " seconds"
        }
        else
        {
            timer.invalidate()
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FourthViewControllerID") as! FourthViewController
            self.present(newViewController, animated: true, completion: nil)
        }
    }

    @IBAction func add(_ sender: Any) {
        time = time + 300
        self.hoursLabel = Int(time) / 3600
        
        self.minutesLabel = Int(time) / 60 % 60
        
        self.secondsLabel = Int(time) % 60
        timeLabel.text = String(self.hoursLabel) + " hours : " + String(self.minutesLabel) + " minutes : " + String(self.secondsLabel) + " seconds"
    }
    
    @IBAction func minus(_ sender: Any) {
        if time >= 300
        {
            time = time - 300
            self.hoursLabel = Int(time) / 3600
            
            self.minutesLabel = Int(time) / 60 % 60
            
            self.secondsLabel = Int(time) % 60
            timeLabel.text = String(self.hoursLabel) + " hours : " + String(self.minutesLabel) + " minutes : " + String(self.secondsLabel) + " seconds"
        }
    }
    
    @IBAction func startstopbutton(_ sender: AnyObject) {
        if (isStarted)
        {
            timer.invalidate()
            isStarted = false
            self.changebutton.setTitle("Start", for: [])
            changebutton.backgroundColor = UIColor(hue: 0.5972, saturation: 0.83, brightness: 0.99, alpha: 1.0)
        }
        else
        {
            self.changebutton.setTitle("Stop", for: [])
            changebutton.backgroundColor = UIColor(hue: 0.0111, saturation: 0.64, brightness: 0.92, alpha: 1.0)
            isStarted = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decrease), userInfo: nil, repeats: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.time = hrs * 3600 + (mins + range) * 60
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()


        // Do any additional setup after loading the view.
        
        changebutton.layer.cornerRadius = 12
        
        plusfive.layer.masksToBounds = true
        plusfive.layer.cornerRadius = plusfive.frame.width/2
        
        minusfive.layer.masksToBounds = true
        minusfive.layer.cornerRadius = minusfive.frame.width/2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
                    
                    let location = subThoroughfare + " " + thoroughfare + " " + subLocality + " " + subAdministrativeArea + ", " + country + " " + postCode
                    
                    UserDefaults.standard.set(location, forKey: "location")
                    
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
