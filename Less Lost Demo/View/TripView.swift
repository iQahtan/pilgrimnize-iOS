//
//  TripView.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/12/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit

class TripView: UIView {
    
    var route: Route? {
        didSet{
            setupRoute()
        }
    }
    let startButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Strart", for: .normal)
        
       return button
    }()
    let addressLab: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        return lab
    }()
    let stepsButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Route", for: .normal)
        
        return button
    }()
    
    let toogleButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("^", for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        backgroundColor = .white
    }
    func setupStackView() {
        
//        addSubview(toogleButton)
//        toogleButton.leftAnchor.constraint(equalTo: leftAnchor,constant:18).isActive = true
//        toogleButton.rightAnchor.constraint(equalTo: rightAnchor,constant:-18).isActive = true
//        toogleButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
//        toogleButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(addressLab)
        addressLab.leftAnchor.constraint(equalTo: leftAnchor,constant:18).isActive = true
        addressLab.rightAnchor.constraint(equalTo: rightAnchor,constant:-18).isActive = true
        addressLab.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        addressLab.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [startButton,stepsButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.spacing = 5
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: addressLab.bottomAnchor,constant:5).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor,constant:18).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -18).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let buttons = stackView.subviews
        for btn in buttons {
            btn.layer.cornerRadius = 20
            btn.layer.masksToBounds = true
            btn.layer.borderColor = UIColor.rgb(red: 47, green: 128, blue: 197).cgColor
            btn.layer.borderWidth = 2
        }
    }
    fileprivate func setupRoute() {
        guard let route = self.route else { return}
        
        let arrayOfString = route.destnation.components(separatedBy: ",")
        print("arrayOfString",arrayOfString)
        
        if arrayOfString.count >= 3 {
        let attributedString = NSMutableAttributedString(string: arrayOfString[1], attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.gray])
        
            attributedString.append( NSMutableAttributedString(string: "\n \(arrayOfString[2])", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.lightGray]))
            self.addressLab.attributedText = attributedString
        }else {
            self.addressLab.attributedText = NSMutableAttributedString(string: "Unnamed Road", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.lightGray])
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
