//
//  CollectionViewCell.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/7/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import CoreLocation
class CustomCollectionViewCell:UICollectionViewCell{
    
    var report: Report? {
        didSet{
            guard let report = report else { return }
            discription.text = report.describ
            date.text = report.craetionDate.timeAgoDisplay()
            phoneNumber.text = "\(report.phone)"
            location.text = report.locationName
//            if report.activation == 1 {
//                activeView.backgroundColor = .green
//            }
        }
    }
    
    var user:User? {
        didSet {
            guard let user = user else { return }
            if user.userType == 0 {
                
            }else if user.userType == 2 {
                
            }
        }
    }
    let discription: UILabel = {
       let lab = UILabel()
        lab.text = "Report a broblem"
        lab.textColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        return lab
    }()
    let date: UILabel = {
       let lab = UILabel()
        lab.textAlignment = .right
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = UIColor.rgb(red: 179, green: 190, blue: 196)
        lab.translatesAutoresizingMaskIntoConstraints = false
//        lab.text = "12/12/1439 "
        lab.numberOfLines = 0
        
        return lab
    }()
    let location: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textColor = UIColor.rgb(red: 51, green: 104, blue: 146)
//        lab.text = "Makkah"
        lab.numberOfLines = 0
//        lab.font = UIFont.systemFont(ofSize: 11)
        
        return lab
    }()
    let phoneNumber: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textColor = UIColor.rgb(red: 179, green: 190, blue: 196)
        lab.numberOfLines = 0
//        lab.font = UIFont.systemFont(ofSize: 11)
        return lab
    }()
    let activeView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(discription)
        discription.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        discription.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        discription.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        discription.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(phoneNumber)
        phoneNumber.topAnchor.constraint(equalTo: discription.bottomAnchor).isActive = true
        phoneNumber.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        phoneNumber.heightAnchor.constraint(equalToConstant: 35).isActive = true
        phoneNumber.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        addSubview(location)
        location.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor).isActive = true
        location.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        location.heightAnchor.constraint(equalToConstant: 35).isActive = true
        location.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        
        addSubview(date)
        date.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        date.widthAnchor.constraint(equalToConstant: 100).isActive = true
        date.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        
//        layer.masksToBounds = NO
        let shadowPath = UIBezierPath(rect: bounds)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
        
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

