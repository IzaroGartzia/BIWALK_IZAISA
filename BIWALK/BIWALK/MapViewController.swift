//
//  MapViewController.swift
//  BIWALK
//
//  Created by  on 6/2/19.
//  Copyright © 2019 Izaisa. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var hAccuracy: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var vAccuracy: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var startLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        startLocation = nil
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: CLLocation = locationManager.location!

        mapView.centerCoordinate=latestLocation.coordinate

        print(latestLocation.coordinate.latitude)
        print(latestLocation.coordinate.longitude)
        
        var coordenadas = [CLLocationCoordinate2D]()
        
        coordenadas.append(latestLocation.coordinate)
        
        let polyline = MKPolyline(coordinates: coordenadas, count: coordenadas.count)
        
        mapView.addOverlay(polyline)
        
       
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //Return an `MKPolylineRenderer` for the `MKPolyline` in the `MKMapViewDelegate`s method
        if let polyline = overlay as? MKPolyline {
            let testlineRenderer = MKPolylineRenderer(polyline: polyline)
            testlineRenderer.strokeColor = .blue
            testlineRenderer.lineWidth = 2.0
            return testlineRenderer
        }
        fatalError("Something wrong...")
        //return MKOverlayRenderer()
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
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
