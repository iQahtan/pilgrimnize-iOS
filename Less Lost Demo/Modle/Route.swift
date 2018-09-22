//
//  Route.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/14/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit

class Route: NSObject {
    let destnation:String
    let distance:String
    let duration:String
    
     init(destnation:String,value:[String:Any]) {
        self.destnation = destnation
        self.distance = value["distance"] as? String ?? ""
        self.duration = value["duration"] as? String ?? ""
    }
}
