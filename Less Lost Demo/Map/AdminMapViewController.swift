//
//  AdminMapView.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/5/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
class AdminMapViewController: UIViewController {
    
    // this is emploies
    var mapView: GMSMapView?
    var locationManager: CLLocationManager?
    var Users:[User]?
//    var casees: [Cases]?
    var zoomLevel:Float = 15
    /*
     HERE THE ADMINE CAN SEE EVERY THING LIVE
     - CASESS == CASSES TABLE
     -FEATEH THE USERS AND GATHER THEM WITH CLASS TYPE
     
 */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUserLoaction()
//        addMarkersToMap()
    }
    func setupUserLoaction(){
        view.backgroundColor = .gray
        
        
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager?.location?.coordinate.latitude)!, longitude: (locationManager?.location?.coordinate.longitude)!, zoom: zoomLevel)
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView?.settings.myLocationButton = true
        mapView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(mapView!)
        mapView?.isMyLocationEnabled = true
        mapView?.isHidden = true
        
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
        
//        let utlite = Utilties()
//
//        let srcLocation = locationManager?.location?.coordinate
//        let dstLocation = CLLocationCoordinate2DMake((cases?.location[0])!, (cases?.location[1])!)
//        utlite.location? = CLLocation(latitude: srcLocation.latitude, longitude: srcLocation.longitude)
//        utlite.setupRequest(src: srcLocation, dst: dstLocation)
        
    }
//    func addMarkersToMap() {
//        guard let casees = casees else {return}
//        for ma in 0..<casees.count{
//            let marker = GMSMarker()
//            let casee = casees[ma]
//            marker.position = CLLocationCoordinate2DMake(casee.location[0], casee.location[1])
//            marker.title = casee.title
//            marker.icon = GMSMarker.markerImage(with: .black)
//            marker.snippet = "gggg"
//            marker.map = mapView
//        }
//    }
}
extension AdminMapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else { return}
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: zoomLevel)
        
        if mapView!.isHidden {
            mapView?.isHidden = false
            mapView?.camera = camera
        } else {
            mapView?.animate(to: camera)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("CLLocationManagerDelegate---3")
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView?.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            mapView?.isHidden = false
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
