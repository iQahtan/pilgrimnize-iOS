//
//  Report.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/7/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
class Report: NSObject {
    
    let uid:String
    let describ:String
    var location:[Double]
    let craetionDate : Date
    
    let phone:Int
    let officNumber: Int
    
    var activation:Int
    var reportedUserUid:String
    var userInCharge:String
    
    let employReport:String
    let endDate : Date
    
    let locationName : String
    
    init(uid: String,dict:[String:Any]) {
        
        self.uid = uid
        let sectondFrom1970 = dict["creationDate"] as? Double ?? 0
        self.craetionDate = Date(timeIntervalSince1970: sectondFrom1970)
        self.describ = dict["describion"] as? String ?? ""
        self.phone = dict["phoneNum"] as? Int ?? 0
        self.activation = dict["active"] as? Int ?? 0
        self.reportedUserUid = dict["reportedUserUid"] as? String ?? ""
        self.location = dict["location"] as? [Double] ?? []
        self.userInCharge = dict["userId"] as? String ?? ""
        self.officNumber = dict["officNumber"] as? Int ?? 0
        self.locationName = dict["locationName"] as? String ?? ""
        
        self.employReport = dict["employReport"] as? String ?? ""
        let endDateSecondFrom1970 = dict["endDate"] as? Double ?? 0
        self.endDate = Date(timeIntervalSince1970: endDateSecondFrom1970)
    }
    func getDate() {
        
    }
}
