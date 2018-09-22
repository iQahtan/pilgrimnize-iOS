//
//  Service.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/9/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import UserNotifications

class Service: NSObject {
    
    var users = [User]()
    var reports = [Report]()
    var finshedReprots = [Report]()
    var theRootViewController: TheRootViewController?
    var reportsMarkers = [GMSMarker]()
    
    func fetchAllTheUsers(user:User) {
        print("Rulls Admin ======")
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            guard let dictonary = snapshot.value as? [String:Any] else { return}
            if snapshot.key != user.uid {
                let user = User(uid: snapshot.key, dictionary: dictonary)
                self.users.append(user)
            }
        }) { (error) in
            print("Field fetching users",error)
        }
    }
    func fetchReports(user:User) {
        print("Rulls Admin ==dttq====")
        if (user.userType == 0) || (user.userType == 1) {
            let reff = Database.database().reference().child("Reports")
                reff.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
                let reportUid = snapshot.key
                guard let reportsDict = snapshot.value as? [String:Any] else { return }
                    for k in reportsDict {
                        guard let value = k.value as? [String:Any] else { return}
                        
                        let report = Report(uid: reportUid, dict: value)
                        if report.officNumber == self.theRootViewController?.user?.officNumber && report.activation == 0  {
//                            if  report.activation == 2 {
//                                self.finshedReprots.insert(report, at: 0)
//                            }else  {
                                self.reports.insert(report, at: 0)
                                /// send notification
                                self.setupNotificationContent(report: report)
                            
//                            }
                        }
                    }
                    print("kfdfd",self.reports.count)
                        self.theRootViewController?.collectionView?.reloadData()
//                    }
            }) { (error) in
                print("Field to load reports",error)
            }
        }else if user.userType == 1{
            
        }
        
    }
    func listenToChanging() {
        Database.database().reference().child("Reports").observe(.childChanged, with: { (snapshot) in
            print(snapshot)
            var rep :Report?
            guard let dict = snapshot.value as? [String:Any] else { return}
            var repoDict:[String:Any]?
            for i in dict.values {
                guard let repoDict = i as? [String:Any] else { return}
                let repo = Report(uid: snapshot.key, dict: repoDict)
                
                rep = repo
                
            }
            for (index,repo) in self.reports.enumerated() {
                guard let rep = rep else { return}
                if repo.uid == rep.uid && rep.activation != 0 {
                        self.changeTheMarkerColor(report: rep)
                    
                    print("GGGGGGGG")
                    self.reports.remove(at: index)
                    self.theRootViewController?.collectionView?.reloadData()
                }
            }
        }) { (erorr) in
            print(erorr)
        }
    }
    func changeTheMarkerColor(report:Report){
        for (index,marker) in reportsMarkers.enumerated(){
            if report.activation == 1 {
                if report.describ == marker.title  {
                    print("11111")
                    
                    marker.icon = GMSMarker.markerImage(with: .blue)
                }
            }else if report.activation == 2{
                reportsMarkers.remove(at: index)
            }
        }
    }
    func addReportsMarkersToMap(mapView: GMSMapView) {
//        guard let reports reports else { return }
        print(reports.count, "Users",users.count)
        for report in reports {
            let marker = GMSMarker()
            print(reportsMarkers.count)
            marker.position = CLLocationCoordinate2DMake(report.location[0], report.location[1])
            print(marker.position)
            marker.title = report.describ
            marker.icon = GMSMarker.markerImage(with: .red)
            marker.snippet = "\(report.phone)"
            reportsMarkers.append(marker)
            print("reportsssss",report.describ)
            marker.map = mapView
        }
    }
    func addMarker(title:String,lat:Double,long:Double,user:User){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.title = title
        marker.icon = GMSMarker.markerImage(with: .black)
        marker.snippet = "gggg"
    }
    
    func setupNotificationContent(report:Report){
        print("setupNotificationContent")
        let content = UNMutableNotificationContent()
        content.title = "\(report.phone)"
//        let locationName = getTheLocationName(location: report.location)
        content.subtitle = report.locationName
        content.body = report.describ
        content.badge = reports.count as NSNumber
        content.sound = UNNotificationSound.default()

        let notifiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let uuid = UUID().uuidString
        let notifiId = "ReportAdd\(uuid)"
        let request = UNNotificationRequest(identifier: notifiId, content: content, trigger: notifiTrigger)

        UNUserNotificationCenter.current().add(request) { (erorr) in
            print("Field to load the notification",erorr)
            UNUserNotificationCenter.current().delegate = self
        }
    }
    func fetchUsers(user:User) {
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            guard let dictonary = snapshot.value as? [String:Any] else { return}
            if snapshot.key != user.uid {
                let user = User(uid: snapshot.key, dictionary: dictonary)

                if self.theRootViewController?.user?.officNumber == user.officNumber{
                    self.users.append(user)
                }
                //                self.addMarker(title: user.username, lat: user.location[0], long: user.location[1])
            }
        }) { (error) in
            print("Field fetching users",error)
        }
    }
}
extension Service:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        completionHandler( [.alert, .badge, .sound])
    }


    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.

     public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {

        switch response.actionIdentifier {
        case "action1":
            print("Action First Tapped")
        case "action2":
            print("Action Second Tapped")
        default:
            break
        }
        completionHandler()
    }
}
