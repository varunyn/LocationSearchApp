//
//  FirstViewController.swift
//  JSONParsingUsingDecodable
//
//  Created by Varun Yadav on 10/12/17.
//  Copyright © 2017 Varun Yadav. All rights reserved.
//

import UIKit
import CoreLocation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class FirstViewController: UIViewController, CLLocationManagerDelegate {

  
  let locationManager = CLLocationManager()
    
    @IBOutlet weak var zip: UITextField!
    
    @IBOutlet weak var place: UITextField!
    
    @IBAction func SearchButton(_ sender: UIButton) {
        
        let StoryBoard = UIStoryboard(name: "Main", bundle: nil)
       let SecondVC = StoryBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        SecondVC.zipUrl = zip.text!
        SecondVC.placeUrl = place.text!
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    
    @IBAction func getLocation(_ sender: UIButton) {
        
    locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager : CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let location = locations[0]
        if locations.count > 0 {
            manager.stopUpdatingLocation()
        }
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil
            {
                print ("THERE WAS AN ERROR")
            }
            else
            {
                if let places = placemark?[0]
                {
                    self.zip.text = places.postalCode
                    print( places.postalCode)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        self.hideKeyboardWhenTappedAround()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
