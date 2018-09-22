//
//  Utiltes.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/5/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
class Utilties: NSObject {
    
    var shortestRouet = [Double]()
    var allRoutes = [[String:Any]]()
    var location : CLLocation?
    
    func setupRequest(src:CLLocationCoordinate2D,dst:CLLocationCoordinate2D) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(src.latitude),\(src.longitude)&destination=\(dst.latitude),\(dst.longitude)&sensor=false&mode=driving")!
        print("dstttttttttt",dst)
        
        let request = URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let er = error {
                print("Field ", er)
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                let routes = json["routes"] as? [Any]
                
                let overview_polyline = routes?[0] as?[String:Any]
                let optionsObject = overview_polyline!["legs"] as? [Any]
                let opt = optionsObject![0] as? [String:Any]
                let op =  opt!["steps"] as? [Any]
                for o in  op! {
                    let oo = o as? [String:Any] /// THE ROUTE DETIELS
                    
                    let valueToComper = oo!["distance"] as? [String:Any]
                    let value = valueToComper!["value"] as? Double
                    self.allRoutes.append(oo!)
                    self.shortestRouet.append(value!)
                }
                print(self.shortestRouet,self.allRoutes)
//                self.drawTheShortestRoute(routs: self.allRoutes, values: self.shortestRouet, src: (self.location?.coordinate)!)
                
                
            }catch let error as NSError {
                print("Field to parse JSON", error)
            }
        }
        request.resume()
    }
    func drawTheShortestRoute(routs:[[String:Any]],values:[Double],src: CLLocationCoordinate2D) {
        print("--------==--=-=",values)
        print("--------==--=-=",values.min())
        let index = values.index(of: values.min()!)
        
        let polyline = routs[index!]
        
        guard let pp = polyline["polyline"] as? [String:Any] else { return}
        guard let ll = pp["points"]  as? String else { return}
        print("--------=3")
        DispatchQueue.main.async(execute: {
            let path = GMSPath(fromEncodedPath: ll)
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 5.0
            polyline.strokeColor = UIColor.blue
            
//            self.mapView.camera = GMSCameraPosition.camera(withLatitude: src.latitude, longitude: src.longitude, zoom: 17)
            
        })
        print("--------=")
    }
}
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
        
    }
}
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?,bottom: NSLayoutYAxisAnchor?, paddingTop: CGFloat,paddingLeft: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            self.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            self.endEditing(true)
        }
}
