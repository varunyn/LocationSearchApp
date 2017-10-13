//
//  ViewController.swift
//  JSONParsingUsingDecodable
//
//  Created by Varun Yadav on 10/12/17.
//  Copyright © 2017 Varun Yadav. All rights reserved.
//

import UIKit
import MapKit

struct Response: Decodable {
    let query: query
}

struct query: Decodable {
    let results: results
}

struct results: Decodable {
    let Result: [Result]
}

struct Result: Decodable {
   let MapUrl : URL
   let Address: String
   let Title : String
    let Latitude: String
    let Longitude: String
    let Phone: String
}


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var zipUrl = ""
    var placeUrl = ""
    var titles = [String]()
    var lat = [String]()
    var lon  = [String]()
    var add = [String]()
    var phoneNo = [String]()
     var an = [MKPointAnnotation]()
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titles = [String]()
        add = [String]()
         phoneNo = [String]()
        
         an = [MKPointAnnotation]()
        
        let iniURL = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D%27"
        let finalUrl = "%27%20and%20query%3D%27"
        let onemoreUrl = "%27&format=json&callback="
        let midURL = iniURL + zipUrl + finalUrl + placeUrl + onemoreUrl
        
        
        let url  = URL.init(string: midURL)
        
        do{
            let data = try Data.init(contentsOf: url!)
           let  DecodedJSON = try JSONDecoder().decode(Response.self, from: data)
            
            for i in stride(from: 0, to: DecodedJSON.query.results.Result.count, by: 1){
                print(DecodedJSON.query.results.Result[i].Title)
                titles.append(DecodedJSON.query.results.Result[i].Title)
                 lat.append(DecodedJSON.query.results.Result[i].Latitude)
                 
                 lon.append(DecodedJSON.query.results.Result[i].Longitude)
                add.append(DecodedJSON.query.results.Result[i].Address)
                 phoneNo.append(DecodedJSON.query.results.Result[i].Phone)
            }
            
        }
        catch let error {
            print(error)
        }
        
        for j in 0..<lat.count{
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
            let initialLocation = CLLocationCoordinate2DMake(Double(lat[j])!,Double(lon[j])!)
            let region = MKCoordinateRegionMake(initialLocation, span)
            map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = initialLocation
            annotation.title = titles[j]
            annotation.subtitle = phoneNo[j]
            map.addAnnotation(annotation)
            an.append(annotation)
        }
           
         table.register(UINib(nibName: "CustomCell", bundle: nil),forCellReuseIdentifier: "CustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
      //  CustomCell.titleLabel.text = titleArray[indexPath.row]
       
        cell.titleLabel.text = titles[indexPath.row]
        cell.addLabel.text = add[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       self.map.showAnnotations(self.map.annotations, animated: true)

        var selectedAnnotations = an[indexPath.row]
        
        self.map.selectAnnotation(selectedAnnotations , animated: true)

}

    
}
