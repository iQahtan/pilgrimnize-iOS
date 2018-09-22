//
//  ReportsCell.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/14/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit

class ReportsCell: UITableViewCell {
    
    var report : Report? {
        didSet {
            guard let report = report else { return}
            reportDescribion.text = report.describ
            employReport.text = report.userInCharge
            locationName.text = report.locationName
            timeLab.text = report.endDate.timeAgoDisplay()
        }
    }
    let reportDescribion: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    let employReport: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    let timeLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textColor = UIColor.lightGray
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    let locationName:UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.lightGray
        return lab
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(reportDescribion)
        addSubview(employReport)
        addSubview(timeLab)
        addSubview(locationName)
        
        reportDescribion.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddingTop: 5, paddingLeft: 5, paddingRight: 5, paddingBottom: 0, width: 0, height: 60)
        
        employReport.anchor(top: reportDescribion.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddingTop: 5, paddingLeft: 5, paddingRight: 5, paddingBottom: 0, width: 0, height: 60)
        
        locationName.anchor(top: employReport.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, paddingTop: 5, paddingLeft: 5, paddingRight: 5, paddingBottom: 0, width: 0, height: 30)
        
        timeLab.anchor(top: locationName.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, paddingTop: 5, paddingLeft: 5, paddingRight: 0, paddingBottom: 0, width: 100, height: 40)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
