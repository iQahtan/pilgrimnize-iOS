//
//  CustomTableViewCell.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/28/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
class CustomTableViewCell: UITableViewCell {
    
    let countryName:UILabel = {
        let lab = UILabel()
        return lab
    }()
    let countryCode:UILabel = {
        let lab = UILabel()
        lab.textAlignment = .right
        return lab
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(countryName)
        countryName.anchor(top: topAnchor, left: leftAnchor, right: nil, bottom: bottomAnchor, paddingTop: 2, paddingLeft: 8, paddingRight: 0, paddingBottom: 2, width: 240, height: 0)
        
        addSubview(countryCode)
        countryCode.anchor(top: topAnchor, left: nil, right: rightAnchor, bottom: bottomAnchor, paddingTop: 2, paddingLeft: 0, paddingRight: 8, paddingBottom: 2, width: 80, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
