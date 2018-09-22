//
//  RouteView.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/12/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
class RouteView: UIView {
    var route: Route? {
        didSet{
            setupRoute()
        }
    }
    let desstens: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
//        let attributedString = NSMutableAttributedString(string: "15 min", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.heavy),NSAttributedStringKey.foregroundColor:UIColor.orange])
//        let attrabuted = NSMutableAttributedString(string: "\n 84 km . 7:01", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.lightGray])
//        attributedString.append(attrabuted)
        lab.numberOfLines = 0
//        lab.attributedText = attributedString
        return lab
    }()
    let exitBtn: UIButton = {
       let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .red
        btn.setTitle("Exit", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()
    let toogleButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("^", for: .normal)
        return button
    }()
    let endTheReport:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.setTitle("End the report", for: .normal)
        btn.backgroundColor = .black
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
//        addSubview(toogleButton)
//        toogleButton.leftAnchor.constraint(equalTo: leftAnchor,constant:18).isActive = true
//        toogleButton.rightAnchor.constraint(equalTo: rightAnchor,constant:-18).isActive = true
//        toogleButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
//        toogleButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(desstens)
        desstens.leftAnchor.constraint(equalTo: leftAnchor,constant:18).isActive = true
        desstens.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        desstens.heightAnchor.constraint(equalToConstant: 60).isActive = true
        desstens.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        addSubview(exitBtn)
        exitBtn.rightAnchor.constraint(equalTo: rightAnchor,constant:-18).isActive = true
        exitBtn.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        exitBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        exitBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        exitBtn.layer.cornerRadius = 20
        exitBtn.layer.masksToBounds = true
        
        addSubview(endTheReport)
        endTheReport.rightAnchor.constraint(equalTo: exitBtn.leftAnchor,constant:-18).isActive = true
        endTheReport.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        endTheReport.heightAnchor.constraint(equalToConstant: 45).isActive = true
        endTheReport.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        endTheReport.layer.cornerRadius = 20
        endTheReport.layer.masksToBounds = true
    }
    fileprivate func setupRoute() {
        guard let route = self.route else { return}
        
        
        let attributedText = NSMutableAttributedString(string: route.distance, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.heavy),NSAttributedStringKey.foregroundColor:UIColor.orange])
        
        attributedText.append(NSMutableAttributedString(string:"\n \(route.duration)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.lightGray]))

        self.desstens.attributedText = attributedText
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
