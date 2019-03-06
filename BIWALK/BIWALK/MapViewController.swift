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
import Firebase

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var hAccuracy: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var vAccuracy: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var metrosLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var startLocation: CLLocation!
    //Para hacer el cronometro
    var count = 0
    var minute = 0
    var hour = 0
    var km = 0.0
    var latitudes =  [Double] ()
    var longitudes = [Double] ()

    @IBOutlet weak var textNombreRuta: UITextField!
    
    //var timer = Timer()
    
    
    
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
    
    
    func counter() {
        
        count += 1
        if count > 9 {
            secondLabel.text = "\(count)"
            if count == 60 {
                count = 0
                secondLabel.text = "00"
                minute += 1
                if minute > 9 {
                    minuteLabel.text = "\(minute)"
                    if minute == 60 {
                        minute = 0
                        minuteLabel.text = "00"
                        hour += 1
                        if hour > 9 {
                            hourLabel.text = "\(hour)"
                        }
                        else {
                            hourLabel.text = "0\(hour)"
                        }
                    }
                }
                else{
                    minuteLabel.text = "0\(minute)"
                }
                
                
            }
        }
        else {
            secondLabel.text = "0\(count)"
        }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: CLLocation = locationManager.location!

//        mapView.centerCoordinate=latestLocation.coordinate

        print(latestLocation.coordinate.latitude)
        print(latestLocation.coordinate.longitude)
        

 
        latitudes.append(latestLocation.coordinate.latitude)
        longitudes.append(latestLocation.coordinate.longitude)
        
        
        
        var coordenadas = [CLLocationCoordinate2D]()
        
        coordenadas.append(latestLocation.coordinate)
        
        let polyline = MKPolyline(coordinates: coordenadas, count: coordenadas.count)
        
        // Para hacer zoom en el mapview y que salga justo donde estamos
        let span:MKCoordinateSpan=MKCoordinateSpan (latitudeDelta: 0.05, longitudeDelta:0.05)
        
        let region:MKCoordinateRegion=MKCoordinateRegion (center: latestLocation.coordinate, span: span)
        
        
        
        mapView.addOverlay(polyline)
        // (ERROR         mapView.setRegion(region, animated: true)
        mapView.setRegion(region, animated: true)
        
        // Comprobar que no sea la primera vez que entre
        if  latitudes.count >= 2{

        
       let location1 = CLLocation(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
        print (location1)
       let location2 = CLLocation(latitude: latitudes[latitudes.count-2], longitude: longitudes[longitudes.count-2])
        print (location2)
        let distanceInMeters = location1.distance(from: location2)
        print(distanceInMeters)
        
        km = (distanceInMeters/1000) + km
        
        metrosLabel.text = "Recorrido : \(km.rounded())"
        
        }

        
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
    var contador = true
    
    
    @IBAction func startButton(_ sender: UIButton) {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: contador, block: { timer in
            self.count += 1
            if self.count > 9 {
                self.secondLabel.text = "\(self.count)"
                if self.count == 60 {
                    self.count = 0
                    self.secondLabel.text = "00"
                    self.minute += 1
                    if self.minute > 9 {
                        self.minuteLabel.text = "\(self.minute)"
                        if self.minute == 60 {
                            self.minute = 0
                            self.minuteLabel.text = "00"
                            self.hour += 1
                            if self.hour > 9 {
                                self.hourLabel.text = "\(self.hour)"
                            }
                            else {
                                self.hourLabel.text = "0\(self.hour)"
                            }
                        }
                    }
                    else{
                        self.minuteLabel.text = "0\(self.minute)"
                    }
                    
                    
                }
            }
            else {
                self.secondLabel.text = "0\(self.count)"
            }
        })
   }
    
    @IBAction func botonGuardar(_ sender: Any) {
        
        contador = false
        // AÑADIR DOCUMENTOS A FIRESTORE
        var ref: DocumentReference? = nil
        ref = db.collection("rutas").addDocument(data: [
            "nombre" : textNombreRuta.text,
            "latitud": latitudes,
            "longitud": longitudes,
            "km": km,
            "horas": hour,
            "mins": minute,
            "seg": count
        ]) { err in
            if let err = err {
                print("Error al añadir el documento: \(err)")
            } else {
                print("Documento añadido con el ID: \(ref!.documentID)")
            }
        }
        
        // PARAR EL CRONOMETRO
        // self.hourLabel.text = "00"
        // self.minuteLabel.text = "00"
        // self.secondLabel.text = "00"
        
    }


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


