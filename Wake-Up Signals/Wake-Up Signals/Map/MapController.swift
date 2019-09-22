//
//  MapController.swift
//  Wake-Up Signals
//
//  Created by Patrik Kemeny on 18/8/19.
//  Copyright © 2019 Patrik Kemeny. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

struct SnappedPoints: Decodable {
    let snappedPoints: [String: [Point]]
}

struct Point: Decodable {
    let location: Location
    let originalIndex: Int
    let placeID:String
}
struct Location: Decodable {
    let latitude: Double?
    let longitude: Double?
}

class MapController: UIViewController, CLLocationManagerDelegate {
    
    let api_Key = "AIzaSyC95R7uJKmOBYLfplh1wxqudUuf6SXikmY"
    //location
    var driverlocation = CLLocationManager()
    //Driver
    let driver = Driver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        self.driverlocation.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            driverlocation.delegate = self
            driverlocation.desiredAccuracy = kCLLocationAccuracyBest
            driverlocation.startUpdatingLocation()
            guard let location = driverlocation.location?.coordinate else { return }
            driver.updateLocation(lat: location.latitude, long:  location.longitude)
            
        }
        GMSServices.provideAPIKey(api_Key)
        let camera = GMSCameraPosition.camera(withLatitude: driver.latitude, longitude: driver.longitude, zoom: 17)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        let currentLocation = CLLocationCoordinate2D(latitude:  driver.latitude, longitude: driver.longitude)
        let marker = GMSMarker(position: currentLocation)
        let markerView = UIImageView(image: #imageLiteral(resourceName: "icons8-car-30"))
        marker.iconView = markerView
        marker.title = "Your Current Location + Speed km/h"
        marker.snippet = "your speed"
        marker.map = mapView
        //get Name from API Place ID
        let str = createUrlRequestStringNearestRoads(lat: driver.latitude, long: driver.longitude, api_Key: api_Key)
        //Alamofire.request(str).responseJSON { (response) in
        guard let jsonUrl = URL(string: str) else { return }
        URLSession.shared.dataTask(with: jsonUrl) { (data, response, err) in
            
            guard let data = data else { return}
            do {
                let snappedPoints =  try
                   // JSONDecoder().decode(SnappedPoints.self, from: data)
                    print(response)
            } catch let jsonErr {
               // print("Error JSON parsing:", jsonErr)
            }
         
        }.resume()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard let location = driverlocation.location?.coordinate else { return }
        
        let locValue:CLLocationCoordinate2D = location
        
        driver.updateLocation(lat: locValue.latitude, long:  locValue.longitude)
        
        print("location = \(locValue.latitude) \(locValue.longitude)")
       // let str = "https://roads.googleapis.com/v1/speedLimits?path=-33.86350 151.07760&key="+api_Key
      
        let str = createUrlRequestStringNearestRoads(lat: locValue.latitude, long: locValue.longitude, api_Key: api_Key)
        print(str)
        
        
    }
    //https://roads.googleapis.com/v1/nearestRoads?points=-33.86360868075099,151.0777610305739&key=AIzaSyBOeGYL-Lo-yp1ekar69l1TMGGUQH9TuIs
    func createUrlRequestStringNearestRoads(lat: Double, long: Double,api_Key: String) -> String {
        guard let url:String = "https://roads.googleapis.com/v1/nearestRoads?points=\(lat),\(long)&key=" + api_Key else { return ""}
        print("Nroads URL request: " + url)
       return url
        
   }
    
    func getLocationID(){
        
    }
    
}
