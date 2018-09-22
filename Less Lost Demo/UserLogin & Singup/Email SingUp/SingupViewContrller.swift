//
//  SingupViewContrller.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/4/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseAuth
class SingupViewController: TempletViewController {
    
    
    let smsInfoLab : UILabel = {
        let lab = UILabel()
        let attrubitedString = NSMutableAttributedString(string: "You may receive SMS from us.", attributes: [NSAttributedStringKey.font :UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.lightGray ])
        lab.attributedText = attrubitedString
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    var cooardnit: [Double]?
    
    let logo: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        
        return iv
    }()
    let segmentControle : CustomSegmentedContrl = {
        
        let sc = CustomSegmentedContrl(frame: CGRect(x: 50, y: 160, width: 220, height: 44))
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSwitchView), for: .valueChanged)
        return sc
    }()
    let userNameTv : UITextField = {
        
        let tv = UITextField()
        tv.borderStyle = .roundedRect
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.placeholder = "Enter user name here "
        return tv
    }()
    let emailTv : UITextField = {
        let tv = UITextField()
        tv.borderStyle = .roundedRect
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.placeholder = "Exampl@gmail.com"
        
        return tv
    }()
    let passwordTV : UITextField = {
        
        let tv = UITextField()
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.borderStyle = .roundedRect
        tv.isSecureTextEntry = true
        tv.placeholder = "Password"
        
        return tv
    }()
    let emailNextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing up", for: .normal)
        button.layer.cornerRadius = 5
        let attributedString = NSMutableAttributedString(string: "Next", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 224, green: 236, blue: 248)])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(hendleEmailNextButton), for: .touchUpInside)
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
        return button
    }()
    let emailView :UIView = {
       let emailView = UIView()
        return emailView
    }()
    
    /// PHONE NUMBER FORM
    let phoneView:UIView = {
        let phoneV = UIView()
        return phoneV
    }()
    let phoneN : UITextField = {
        let tv = UITextField()
        tv.borderStyle = .roundedRect
        tv.placeholder = "505555555"
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.keyboardType = .numberPad
        
        return tv
    }()
    let phoneNextButton : UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        let attributedString = NSMutableAttributedString(string: "Next", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 224, green: 236, blue: 248)])
        button.setAttributedTitle(attributedString, for: .normal)

        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
//        button.backgroundColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
//        button.isEnabled = false
        return button
    }()
    let phoneKey:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("+00", for: .normal)
        
        btn.addTarget(self, action: #selector(handlePhoneKey), for: .touchUpInside)
        return btn
    }()
    var arrayOfViews:[UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLab.isHidden = true
        print("locationManager- singupViewDidLoad",theRootViewController?.locationManager?.location)
        arrayOfViews = [emailView,phoneView]
        view.hideKeyboardWhenTappedAround()
        setupLogoView()
        formeTF.isHidden = true
        nextButton.isHidden = true
        setupEmailView()
        setupPhoneView()
        view.bringSubview(toFront: emailView)
    }
    func setupEmailView() {
        view.addSubview(emailView)
        
        emailView.anchor(top: segmentControle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 204  )
        emailView.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        
        
        emailView.addSubview(emailTv)
        self.emailTv.anchor(top: emailView.topAnchor, left: emailView.leftAnchor, right: emailView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        emailView.addSubview(emailNextButton)
        
        self.emailNextButton.anchor(top: self.emailTv.bottomAnchor, left: emailView.leftAnchor, right: emailView.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 44)
        backButton.isHidden = true
    }
    func setupPhoneView() {
        view.addSubview(phoneView)
        phoneView.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        
        phoneView.anchor(top: segmentControle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 15, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 204  )
        
        phoneView.addSubview(phoneN)
        phoneN.anchor(top: phoneView.topAnchor, left: phoneView.leftAnchor, right: phoneView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        phoneView.addSubview(phoneNextButton)
        phoneNextButton.anchor(top: phoneN.bottomAnchor, left: phoneView.leftAnchor, right: phoneView.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 44)
        
        phoneView.addSubview(smsInfoLab)
        smsInfoLab.anchor(top: phoneNextButton.bottomAnchor, left: phoneView.leftAnchor, right: phoneView.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        phoneN.addSubview(phoneKey)
        phoneKey.frame = CGRect(x: CGFloat(phoneN.frame.size.width - 25), y: CGFloat(5), width: CGFloat(55), height: CGFloat(40))
        phoneN.leftViewMode = .always
        phoneN.leftView = phoneKey
        phoneN.layer.borderColor = UIColor.lightGray.cgColor
        phoneN.layer.borderWidth = 0.5
        
        phoneKey.layer.borderColor = UIColor.lightGray.cgColor
        phoneKey.layer.borderWidth = 0.5
        
    }
    @objc func handlePhoneKey() {
        print("handlePhoneKey")
        let countriesTV = CountriesTableView()
        countriesTV.signupVC = self
        let navC = UINavigationController(rootViewController: countriesTV)
        
        present(navC, animated: true, completion: nil)
    }
    func setupLogoView() {
        
        view.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        view.addSubview(logo)
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: -50, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(segmentControle)
        let x = view.center.x - 110
        segmentControle.frame.origin = CGPoint(x: x, y: 145)
        segmentControle.selectedSegmentIndex = 0
        
        print(segmentControle.bounds)
        view.addSubview(loginButton)
        loginButton.anchor(top: nil, left: nil, right: nil, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 20, width: 250, height: 44)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.layer.cornerRadius = 50
        logo.layer.masksToBounds = true
    }
    @objc func handleSwitchView(_ sender:CustomSegmentedContrl){
        print(sender.selectedSegmentIndex)
        view.bringSubview(toFront: arrayOfViews[sender.selectedSegmentIndex])
    }
    @objc override func handleNextButton() {
        
        ///    CHECK THE PHNONE NUMBER LENGHT 
        
        let userNameVC = UserNameViewController()
        print("navigationController",navigationController)
        userNameVC.singupVC = self
        guard let phoneNum =  phoneN.text else { return}
        guard let phoneKey = phoneKey.titleLabel?.text else { return}
        userNameVC.phoneNumber = phoneNum
//            navigationController?.pushViewController(userNameVC, animated: true)
        
        print("hendlePhoneSingup",phoneNum)
        self.setupTheLoader()
//        print("\()\(phoneNum)")
        PhoneAuthProvider.provider().verifyPhoneNumber("\(phoneKey)\(phoneNum)", uiDelegate: nil) { (verificationID, erorr) in
            if let err = erorr {
                print("err",err.localizedDescription)
                let attributedString = NSMutableAttributedString(string: err.localizedDescription, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.red])
                self.stopAnimating()
                self.smsInfoLab.attributedText = attributedString
//                self.errorLabel.isHidden = false
                self.stopAnimating()
            }else {
                print("verificationID",verificationID)
                UserDefaults.standard.set(verificationID, forKey: "firebase_verification")
                UserDefaults.standard.synchronize()
                self.stopAnimating()
                self.navigationController?.pushViewController(userNameVC, animated: true)
            }
        }
    }
    @objc func hendleEmailNextButton(_ sender:UIButton) {
//        self.setupTheLoader()
        guard let userEmail = emailTv.text else {  return}
        let emailUserNameViewController = EmailUserNameViewController()
        emailUserNameViewController.singupVC = self
        emailUserNameViewController.email = userEmail
        navigationController?.pushViewController(emailUserNameViewController, animated: true)
    }
    @objc override func hendleFormeValid() {
        let isFormValid = emailTv.text?.characters.count ?? 0 > 0
        if isFormValid {
            emailNextButton.isEnabled = true
            emailNextButton.backgroundColor  = UIColor.rgb(red: 51, green: 104, blue: 146)
        } else {
            emailNextButton.isEnabled = false
            emailNextButton.backgroundColor = UIColor.lightGray
        }
        let phoneFormValid = phoneN.text?.characters.count ?? 0 > 0
        if phoneFormValid {
            phoneNextButton.isEnabled = true
            phoneNextButton.backgroundColor  = UIColor.rgb(red: 51, green: 104, blue: 146)
        }else {
            phoneNextButton.isEnabled = false
            phoneNextButton.backgroundColor = UIColor.lightGray
        }
    }

}
