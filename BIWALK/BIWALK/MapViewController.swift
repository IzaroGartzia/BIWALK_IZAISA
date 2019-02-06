//
//  MapViewController.swift
//  BIWALK
//
//  Created by  on 6/2/19.
//  Copyright © 2019 Izaisa. All rights reserved.
//

import UIKit
import CoreLocation


class MapViewController: UIViewController,CLLocationManagerDelegate, {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var hAccuracy: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var vAccuracy: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        startLocation = nil
        // Do any additional setup after loading the view.
        
        startWhenInUse()
    }
    
    func startWhenInUse() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    @IBAction func startAlways(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        print(latestLocation.coordinate.latitude)
        print(latestLocation.coordinate.longitude)
        
        var coordenadas = [CLLocationCoordinate2D]()
        
        coordenadas.append(latestLocation.coordinate)
        
        
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        let distanceBetween: CLLocationDistance =
            latestLocation.distance(from: startLocation)
        
        
    }
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
//    var locations = places.map { $0.coordinate }
//    let polyline = MKPolyline(coordinates: &locations, count: locations.count)
//    MKMapView?.add(polyline)
//
//    
//    func addAnnotations() {
//        mapView?.delegate = self
//        mapView?.addAnnotations(places)
//        
//        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
//        mapView?.addOverlays(overlays)
//
//        var locations = places.map { $0.coordinate }
//        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
//        mapView?.add(polyline)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
