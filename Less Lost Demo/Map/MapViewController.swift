//
//  MapViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/5/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import Firebase
class MapViewController: UIViewController {
    
    
    var user:User?
    var locationManager : CLLocationManager?
    var theRootViewController:TheRootViewController?
    var report : Report?
    var mapView : GMSMapView!
    var zoomLevel:Float = 15
    var mapService:MapService?
    var tripeView: TripView?
    var routeView: RouteView?
    var counter = 30
    var reportIndex: Int?
    var reportMarkers = [GMSMarker]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    let employReportTF:UITextField = {
       let tf = UITextField()
        tf.placeholder = "Enter text here"
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = user else { return}
        mapService = MapService()
        print("indexPath.item",reportIndex)
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.startUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = true

        
        if user.userType == 0 {
            setupMapView(lut: (locationManager?.location?.coordinate.latitude)!, lng: (locationManager?.location?.coordinate.longitude)!, zoomLevel: 16, bearing: 270, viewingAngle: 0)
            addUsersMarker()
            theRootViewController?.service?.addReportsMarkersToMap(mapView: mapView)
            observUsersChangedThierLocation()
            observTheReportLocations()
        } else if user.userType == 1 {
            guard let report = report else { return}
            let reportLocation = CLLocationCoordinate2DMake(report.location[0], report.location[1])
            if let srcCoordinate = theRootViewController?.locationManager?.location?.coordinate {
            setupMapView(lut: srcCoordinate.latitude, lng: srcCoordinate.longitude, zoomLevel: 17, bearing: 0, viewingAngle: 0)
            
                    self.mapService?.setupRequest(src: srcCoordinate, dst: reportLocation, mapView: mapView)
//                mapView.animate(toZoom: 18)
            }
            addReportMarkerForEmploy()
            setupRoutesView()
            setupTripeView()
        }
    }
    fileprivate func setupMapView(lut:Double,lng:Double,zoomLevel:Float,bearing:CLLocationDirection,viewingAngle:Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lut, longitude: lng, zoom: zoomLevel,bearing: bearing,
                                              viewingAngle: viewingAngle)
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(mapView)
        mapView.isMyLocationEnabled = true
    }
    fileprivate func observTheReportLocations() {
        /// in case we want to track movment issuee
        Database.database().reference().child("Reports").observeSingleEvent(of: .childAdded) { (snapshot) in
            print("snapshot",snapshot.value)
        }
    }
    func addReportMarkerForEmploy() {
        guard let report = report else { return}
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(report.location[0], report.location[1])
            marker.title = "\(report.phone)"
            marker.icon = GMSMarker.markerImage(with: .red)
            marker.snippet = report.describ
        print("marker.iconView?.frame",marker.icon?.size)
        
            marker.map = mapView
    }
    var blackMarker = [GMSMarker]()
    func addUsersMarker() {
        guard let userss = theRootViewController?.service?.users else {return}
        
        for user in userss {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(user.location[0], user.location[1])
            marker.title = user.username
            let markerIcon = UIImage(named: "if_Map_-_Location_Solid_Style_28_2216337")!.withRenderingMode(.alwaysOriginal)
            
            let markerImageView = UIImageView(image:self.imageWithImage(image: markerIcon, scaledToSize: CGSize(width: 50, height: 60)))
            markerImageView.tintColor = .gray
            marker.iconView = markerImageView
            
            marker.snippet = user.userClass
            blackMarker.append(marker)
            marker.map = mapView
        }
    }
    fileprivate func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = (UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate))!
        UIGraphicsEndImageContext()
        return newImage
    }
    fileprivate func observUsersChangedThierLocation(){
        Database.database().reference().child("Users").observe(.childChanged, with: { (snapshot) in
            print("user has changed thier location")
            guard let user = snapshot.value as? [String:Any] else { return}
            guard let userName = user["username"] as? String else { return}
            guard let newLocation = user["location"] as? [Double] else { return}
            for i in self.blackMarker {
                if i.title == userName {
                    i.position = CLLocationCoordinate2DMake(newLocation[0], newLocation[1])
//                    let markerIcon = UIImage(named: "if_Map_-_Location_Solid_Style_28_2216337")!.withRenderingMode(.alwaysTemplate)
//                    let markerImageView = UIImageView(image:self.imageWithImage(image: markerIcon, scaledToSize: CGSize(width: 50, height: 60)))
                    i.iconView?.tintColor = UIColor.rgb(red: 51, green: 104, blue: 146)
//                    i.iconView = markerImageView
                    i.map = self.mapView
                }
            }
        }) { (error) in
            print("Nothing had changed ")
        }
    }
    var tripViewBottmAnchorConstranit: NSLayoutConstraint?
    
    var tField: UITextField!
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Enter an item"
        tField = textField
    }
    
    @objc func handleEndRportBtn() {
        guard let report = report else {  return}
        let alertView = UIAlertController(title: "End Tripe", message: "Do you want to end the tripe ?", preferredStyle: .alert)
        alertView.addTextField(configurationHandler: configurationTextField)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            print("ok write a report ")
            self.handleYesAndExitBtns(routeConstraint: 100, tripeConstraint: 129)
            self.mapView.padding.bottom = 0
            /// update the reports dict
           print("Item : \(self.tField.text)")
            guard let employMassage = self.tField.text else { return }
            let activationDict: [String:Any] = ["employReport":employMassage,"endDate":Date().timeIntervalSince1970,"active":2]
            Database.database().reference().child("FinshedReports").child(report.uid).child(report.reportedUserUid).updateChildValues(activationDict)
            print("self.theRootViewController?.reports.count",self.theRootViewController?.service?.reports.count)
            //H
            //MARKE:- DELETE REPORT MARKRE
            for (index,marker) in self.reportMarkers.enumerated() {
                if marker.title == report.describ {
                    self.reportMarkers.remove(at: index)
                }
            }
            self.theRootViewController?.service?.reports.remove(at: self.reportIndex!)
            alertView.dismiss(animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: "No", style: .destructive) { (action) in
            print("No Contnue ")
            alertView.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(okAction)
        alertView.addAction(noAction)
        self.present(alertView, animated: true, completion: nil)
        print("handleEndRportBtn")
    }
    func setupTripeView() {
        tripeView = TripView()
        tripeView?.route = mapService?.route
        tripeView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tripeView!)
        
        tripeView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tripeView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tripeView?.heightAnchor.constraint(greaterThanOrEqualToConstant: 129).isActive = true
//        whiteViewLeftAnchor = whiteView.leftAnchor.constraint(equalTo: colliction.leftAnchor)
        tripViewBottmAnchorConstranit =  tripeView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        tripViewBottmAnchorConstranit?.isActive = true
        tripeView?.startButton.addTarget(self, action: #selector(handleCasesLocation), for: .touchUpInside)
        mapView.padding.bottom = 129
    }
    var routeBottomAnchorConstraint:NSLayoutConstraint?
    
    func setupRoutesView() {
        let routeView = RouteView()
        view.addSubview(routeView)
        
        routeView.route = mapService?.route
        routeView.translatesAutoresizingMaskIntoConstraints = false
        routeView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        routeView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        routeView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        routeBottomAnchorConstraint = routeView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:100)
//        view.sendSubview(toBack: routeView)
        routeBottomAnchorConstraint?.isActive = true
        
        routeView.exitBtn.addTarget(self, action: #selector(handleExitRoute), for: .touchUpInside)
        routeView.endTheReport.addTarget(self, action: #selector(handleEndRportBtn), for: .touchUpInside)
    }
    @objc func handleExitRoute() {
        // setup the camera
        handleYesAndExitBtns(routeConstraint: 100, tripeConstraint: 0)
    }
    fileprivate func handleYesAndExitBtns(routeConstraint:CGFloat,tripeConstraint:CGFloat) {
        let camera = GMSCameraPosition.camera(withLatitude: (theRootViewController?.locationManager?.location?.coordinate.latitude)!, longitude: (theRootViewController?.locationManager?.location?.coordinate.longitude)!, zoom: zoomLevel,bearing: 0,
                                              viewingAngle: 0)
        mapView.animate(to: camera)
        mapView.camera = camera
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.mapView.padding.bottom =  129
            self.tripViewBottmAnchorConstranit?.constant = tripeConstraint
            self.tripViewBottmAnchorConstranit?.isActive = true
            self.routeBottomAnchorConstraint?.constant = routeConstraint
            self.routeBottomAnchorConstraint?.isActive = true
            self.view.layoutIfNeeded()
            
        }) { (completion) in
            print("complete animate")
        }
    }
    var startTripe = false
    
    @objc func handleCasesLocation(){
        guard let report = report else { return}
        guard let user = user else { return}
        report.activation = 1
        report.userInCharge = user.username
        // Remove the.root reports
        if let reports = theRootViewController?.service?.reports{
            print(reports)
            for (index,rep) in reports.enumerated() {
                if rep.uid == report.uid {
                    print(rep)
                    theRootViewController?.service?.reports.remove(at: index)
                    theRootViewController?.collectionView?.reloadData()
                }
            }
        }
        let activationDict: [String:Any] = ["active":report.activation,"userId":report.userInCharge]
        Database.database().reference().child("Reports").child(report.uid).child(report.reportedUserUid).updateChildValues(activationDict)
        for marker in reportMarkers {
            if marker.title == report.describ {
                marker.icon = GMSMarker.markerImage(with: .blue)
            }
        }
        print("handleCasesLocation")
        locationManager?.startUpdatingHeading()
        let camera = GMSCameraPosition.camera(withTarget: (locationManager?.location?.coordinate)!, zoom: 19, bearing: 90, viewingAngle: 40)
        mapView.camera = camera
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.mapView.padding.bottom = 40
            self.tripViewBottmAnchorConstranit?.constant = 129
            self.tripViewBottmAnchorConstranit?.isActive = true
            self.routeBottomAnchorConstraint?.constant = 0
            self.routeBottomAnchorConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }) { (completion) in
            print("complete animate")
        }
    }
}
extension MapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("todo task  didUpdateLocations")
        guard let userLocation = locations.last else { return}
        guard let uid = user?.uid else { return}
        
        
//        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: zoomLevel)
        if user?.userType == 1 {
            print("todo task Store the new location to database ")
            user?.location = [userLocation.coordinate.latitude,userLocation.coordinate.longitude]
            let dict :[String:Any] = ["location":[userLocation.coordinate.latitude,userLocation.coordinate.longitude]]
            Database.database().reference().child("Users").child(uid).updateChildValues(dict)
        }
//        else if user?.userType == 0 {
//            print("todo task  fetch all the users location")
//
//        }
        if mapView.isHidden {
            mapView.isHidden = false
//            mapView.camera = camera
        } else {
//            mapView.animate(to: camera)
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
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            mapView.isHidden = false
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("didUpdateHeading")
        
        /// When the trip starts user this camera
//        let camera = GMSCameraPosition.camera(withTarget: (manager.location?.coordinate)!, zoom: 10, bearing: newHeading.magneticHeading, viewingAngle: 0 )
//        mapView.camera.bearing = newHeading.magneticHeading
//        self.mapView.animate(to: camera)
        mapView.animate(toBearing: newHeading.magneticHeading)
    }
    
}
