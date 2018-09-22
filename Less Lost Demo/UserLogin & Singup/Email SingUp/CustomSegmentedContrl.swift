//
//  CustomSegmentedContrl.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/17/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
class CustomSegmentedContrl: UIControl {
    
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateView() {
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let buttonTitles = ["Email","Phone"]
        for buttonTitle in buttonTitles {
            let button = UIButton.init(type: .system)
            let selectedAttrbutedString = NSMutableAttributedString(string: buttonTitle, attributes: [NSAttributedStringKey.font :UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146) ])
//            button.setTitle(buttonTitle, for: .normal)
            
//            button.setTitleColor(.red, for: .normal)
            let unSelectedAttrbutedString = NSMutableAttributedString(string: buttonTitle, attributes: [NSAttributedStringKey.font :UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold),NSAttributedStringKey.foregroundColor:UIColor.black])
            
//            button.setAttributedTitle(unSelectedAttrbutedString, for: .normal)
//            button.setAttributedTitle(selectedAttrbutedString, for: .selected)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
            button.setAttributedTitle(button.isSelected ?  unSelectedAttrbutedString : selectedAttrbutedString, for: .normal)
//        button.setTitleColor(button.isSelected ? UIColor.rgb(red: 51, green: 104, blue: 146) : .lightGray, for: .normal)
        }
        
        buttons[0].setTitleColor(.lightGray, for: .normal)
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        let y =    (self.frame.maxY - self.frame.minY) - 2.0
        
        selector = UIView(frame: CGRect(x: 0, y: y, width: selectorWidth, height: 2.0))

        //selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        addSubview(selector)
        
        // Create a StackView
        
        let stackView = UIStackView.init(arrangedSubviews: buttons)
        stackView.axis = .horizontal
//        stackView.alignment = .fill
        stackView.backgroundColor = .red
        stackView.distribution = .fillEqually
        stackView.spacing = 2.0
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    @objc func buttonTapped(button: UIButton) {
        
        let unSelectedAttrbutedString = NSMutableAttributedString(string: (button.titleLabel?.text)!, attributes: [NSAttributedStringKey.font :UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)])
        button.setAttributedTitle(unSelectedAttrbutedString, for: .normal)
        for (buttonIndex,btn) in buttons.enumerated() {
            if btn != button {
                let unSelectedAttrbutedString = NSMutableAttributedString(string: (btn.titleLabel?.text)!, attributes: [NSAttributedStringKey.font :UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold),NSAttributedStringKey.foregroundColor:UIColor.lightGray])
                btn.setAttributedTitle(unSelectedAttrbutedString, for: .normal)
            }
            if btn == button {
                selectedSegmentIndex = buttonIndex
                
                let  selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.selector.frame.origin.x = selectorStartPosition
                })
                
                btn.setTitleColor(UIColor.rgb(red: 51, green: 104, blue: 146), for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    func updateSegmentedControlSegs(index: Int) {
        
        for btn in buttons {
            btn.setTitleColor(.white , for: .normal)
//            btn.setAttributedTitle(NSMutableAttributedString(string: (btn.titleLabel?.text)!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.red]), for: .normal)
        }
        
        let  selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(index)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.selector.frame.origin.x = selectorStartPosition
        })
        
        buttons[index].setTitleColor(.orange, for: .normal)
        
    }
}
