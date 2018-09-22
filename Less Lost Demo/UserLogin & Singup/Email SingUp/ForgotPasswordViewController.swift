//
//  ForgotPasswordViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/17/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import FirebaseAuth
class ForgotPasswordViewController: UIViewController {
    
    let logo: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        return iv
    }()
    let forgotPasswordLabel: UILabel = {
        let lab = UILabel()
        let attrubitedString = NSMutableAttributedString(string: "Trouble loggig in?", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.lightGray])
        attrubitedString.append(NSMutableAttributedString(string: "\n\n Enter your email and we'll send you a link to get back into your account.", attributes: [NSAttributedStringKey.font :UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.lightGray ]))
        lab.attributedText = attrubitedString
        lab.textAlignment = .center
        lab.numberOfLines = 0
        return lab
    }()
    let emailTv : UITextField = {
        
        let tv = UITextField()
        tv.borderStyle = .roundedRect
        tv.placeholder = "Exampl@gmail.com"
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let sendALinkButton : UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSendALinkButton), for: .touchUpInside)
        //        button.backgroundColor = UIColor(red: 33, green: 156, blue: 234, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        let attributedString = NSMutableAttributedString(string: "Send Login Link", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 224, green: 236, blue: 248)])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
        //        button.titleLabel?.textColor =
        return button
    }()
    let backToLogin: UIButton = {
        let btn = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Back To Log In", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)])
        btn.setAttributedTitle(attributedString, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleBackToLogin), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        view.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    fileprivate func setupViews() {
        
        view.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        view.hideKeyboardWhenTappedAround()
        
        view.addSubview(logo)
        logo.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 25, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.layer.cornerRadius  = 50
        logo.layer.masksToBounds = true
        
        view.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.anchor(top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 100)
        // sugmented UI 40 + 10
        
        view.addSubview(emailTv)
        emailTv.anchor(top: forgotPasswordLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 50, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 40)
        view.addSubview(sendALinkButton)
        sendALinkButton.anchor(top: emailTv.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 44)
        
        view.addSubview(backToLogin)
        backToLogin.anchor(top: nil, left: nil, right: nil, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 20, width: 250, height: 44)
        backToLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let navItemHeight  = self.navigationController?.navigationBar.frame.height else { return}
        let y = navItemHeight + UIApplication.shared.statusBarFrame.height
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print(view.frame.origin.y)
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            //            print(view.frame.origin.y,keyboardSize.size.height)
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let navItemHeight  = self.navigationController?.navigationBar.frame.height else { return}
        
        let y = navItemHeight + UIApplication.shared.statusBarFrame.height
        print("1",self.view.frame.origin.y)
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
                print("2",self.view.frame.origin.y)
            }
        }
    }
    @objc func hendleFormeValid() {
        let isFormValid = emailTv.text?.characters.count ?? 0 > 0
        print("isFormValid",isFormValid)
        if isFormValid {
            sendALinkButton.isEnabled = true
            sendALinkButton.backgroundColor  = UIColor.rgb(red: 51, green: 104, blue: 146)
        } else {
            sendALinkButton.isEnabled = false
            sendALinkButton.backgroundColor = UIColor.lightGray
        }
    }
    @objc func handleSendALinkButton() {
        guard let email = emailTv.text else { return}
        print(email)
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            print("Field to send password reset email",error)
        }
    }
    @objc func handleBackToLogin() {
        navigationController?.popViewController(animated: true)
        print("Back")
    }
}
