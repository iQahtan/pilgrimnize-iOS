//
//  MapService.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/12/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapService: NSObject {
    
    var coordinates = [CLLocationCoordinate2D]()
    var points = [String]()
    var route:Route?
    
    func setupRequest(src:CLLocationCoordinate2D,dst:CLLocationCoordinate2D,mapView:GMSMapView) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        print(dst)
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(src.latitude),\(src.longitude)&destination=\(dst.latitude),\(dst.longitude)&sensor=false&mode=driving")!
        if dst.latitude == 0 || dst.longitude == 0 || src.latitude == 0 || src.longitude == 0 {
            return
        }
        
        let request = URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let er = error {
                print("Field ", er)
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                guard let routes = json["routes"] as? [Any] else { return}
                
                
                guard let rout = routes[0] as? [String:Any] else { return}
                guard let legs = rout["legs"] as? [Any] else { return}
                guard let steps = legs[0] as? [String:Any] else { return}
                
                guard let arrayOfSeps = steps["steps"]as? [Any] else { return}
                
                guard let ovewviewPolyline = rout["overview_polyline"] as? [String:Any] else { return}
                guard let points = ovewviewPolyline["points"] as? String else { return}
                
                for i in arrayOfSeps {
                    guard let dictOflocations =  i as? [String:Any] else { return }
                    guard let polyline = dictOflocations["polyline"] as? [String:Any] else { return }
                    guard let endLocation = dictOflocations["end_location"] as? [String:Any] else { return }
                    
                    guard let lut = endLocation["lat"] as? Double else { return }
                    guard let lng = endLocation["lng"] as? Double else { return }
                    
                    
                    guard let points = polyline["points"] as? String else { return}
                    
                    let coordinate = CLLocationCoordinate2DMake(lut, lng)
                    self.coordinates.append(coordinate)
                    self.points.append(points)
                }
                
                DispatchQueue.main.async {
                    let singleLine = self.drawTheMianeRoute(points: points)
                    singleLine.map = mapView
                }
                
                
                guard let endAddress = steps["end_address"] as?  String else { return}
                guard let distance = steps["distance"] as? [String:Any] else { return}
                guard let distanceText = distance["text"] as? String else { return}
                guard let duration = steps["duration"] as? [String:Any] else  { return }
                guard let durationText = duration["text"] as? String else { return }
                
                let routeValue:[String:Any] = ["distance": distanceText,"duration":durationText]
                self.route = Route(destnation: endAddress, value: routeValue)
                print(self.route?.destnation)
                
            }catch let error as NSError {
                print("Field to parse JSON", error)
            }
        }
        request.resume()
    }
    func drawTheMianeRoute(points:String)-> GMSPolyline {
        var path = GMSPath.init(fromEncodedPath: points)
        var singleLine = GMSPolyline.init(path: path)
        singleLine.strokeWidth = 8
        singleLine.strokeColor = UIColor.green
        return singleLine
    }
    func loopThroughThePoints(userLocation:CLLocationCoordinate2D)->GMSPolyline{
        var detector = 0
        var singleLine = GMSPolyline()
        for (index,elment) in coordinates.enumerated() {
            if userLocation.latitude == elment.latitude {
                print("Dismiss the old polyline")
                detector = index
            }
            let point = points[detector]
            print("==================")
            DispatchQueue.main.async {
                print(userLocation.latitude)
                print(elment)
                var path = GMSPath.init(fromEncodedPath:point)
                singleLine = GMSPolyline.init(path: path)
                singleLine.strokeWidth = 7
                singleLine.strokeColor = .red
            }
            
            print("Change the to new polylin")
        }
        return singleLine
    }
}
