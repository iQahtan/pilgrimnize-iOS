//
//  Sevice.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/4/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
class User: NSObject {
    
    let userType:Int
    let userClass:String
    let uid: String
    let username:String
    let officNumber:Int
    var location:[Double]
    
    init(uid:String,dictionary: [String: Any]) {
        self.uid = uid
        self.officNumber = dictionary["officNumber"] as? Int ?? 0
        self.username = dictionary["username"] as? String ?? ""
        self.userType = dictionary["userType"] as? Int ?? 0
        
        self.location = dictionary["location"] as? [Double] ?? [0,0]
        switch userType {
        case 0:
            userClass = "Admin"
        case 1 :
            userClass = "Employ"
        default:
            userClass = "Customer"
        }
    }
    
//    init(userType:Int,id:Int,email:String,uid:String, location:[Double]) {
//        self.userType = userType
//        self.id = id
//        self.email = email
//        self.uid = uid
//        self.location = location
//        switch userType {
//        case 0:
//            userClass = "Admin"
//        case 1 :
//            userClass = "Service"
//        default:
//            userClass = "clinte"
//        }
//    }
    
}
