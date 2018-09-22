//
//  LoginViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/4/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: TempletViewController {
    
//    let locationManger = CLLocationManager()
//    var user:User?
//    var theRootViewController : TheRootViewController?
    let logo: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        return iv
    }()
    let emailTv : UITextField = {
        
        let tv = UITextField()
        tv.borderStyle = .roundedRect
        tv.placeholder = "Exampl@gmail.com"
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let passwordTV : UITextField = {
        
        let tv = UITextField()
        tv.borderStyle = .roundedRect
        tv.isSecureTextEntry = true
        tv.placeholder = "Password"
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let erLabel: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.adjustsFontSizeToFitWidth = true
        lab.textAlignment = .center
        return lab
    }()
    let loginBtn : UIButton = {
        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hendleLogin), for: .touchUpInside)
//        button.backgroundColor = UIColor(red: 33, green: 156, blue: 234, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        let attributedString = NSMutableAttributedString(string: "Login", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 224, green: 236, blue: 248)])
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
//        button.titleLabel?.textColor =
        return button
    }()
    let forgetPassword : UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("Forgot password?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleForgetPass), for: .touchUpInside)
        //        button.backgroundColor = UIColor(red: 33, green: 156, blue: 234, alpha: 1.0)
//        button.backgroundColor =
        let attrubutedString = NSMutableAttributedString(string: "Forgot password?", attributes: [NSAttributedStringKey.font :UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)])
        button.setAttributedTitle(attrubutedString, for: .normal)
        return button
    }()
    let singupBtn : UIButton = {
        let btn = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: "Sign up", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)]))
        btn.setAttributedTitle(attributedString, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleNewSingup), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        print("theRootViewController LOGIN",theRootViewController)
    }
    override func setupViews() {
        
        view.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        view.hideKeyboardWhenTappedAround()
        view.addSubview(singupBtn)
        
        view.addSubview(logo)
        logo.anchor(top: view.topAnchor, left: view.centerXAnchor, right: nil, bottom: nil, paddingTop: 25, paddingLeft: -50, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        
        view.addSubview(emailTv)
        emailTv.anchor(top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 40)
        
        view.addSubview(passwordTV)
        passwordTV.anchor(top: emailTv.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 44)
        
        view.addSubview(forgetPassword)
        forgetPassword.anchor(top: passwordTV.bottomAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 40, paddingBottom: 0, width: 130, height: 30)
        
        view.addSubview(loginBtn)
        loginBtn.anchor(top: forgetPassword.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 44)

        view.addSubview(erLabel)
        erLabel.anchor(top: loginBtn.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 0)
        singupBtn.anchor(top: nil, left: nil, right: nil, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 20, width: 250, height: 44)
        singupBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.layer.cornerRadius = 50
        logo.layer.masksToBounds = true
        navigationController?.isNavigationBarHidden = true
    }
    @objc func hendleLogin() {
        guard let email = emailTv.text , email.characters.count > 0 else { return}
        guard let password = passwordTV.text , password.characters.count > 0 else { return}
        
        setupTheLoader()
        Auth.auth().signIn(withEmail: email, password: password) { (authResulte, eror) in
            if let er = eror {
                print(er.localizedDescription)
                let attributedString = NSMutableAttributedString(string: er.localizedDescription, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.red])
                self.stopAnimating()
                self.erLabel.attributedText = attributedString
                self.errorLabel.isHidden = false
                self.stopAnimating()
            }else {
                print("signin Succssffly",authResulte?.user.uid)
                self.theRootViewController?.fetchUser()
                self.stopAnimating()
                self.dismiss(animated: true, completion: nil)
            }
        }
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
    @objc override func hendleFormeValid() {
        
        let isFormValid = emailTv.text?.characters.count ?? 0 > 0 && passwordTV.text?.characters.count ?? 0 > 0
        print("isFormValid",isFormValid)
        if isFormValid {
            loginBtn.isEnabled = true
            loginBtn.backgroundColor  = UIColor.rgb(red: 51, green: 104, blue: 146)
        } else {
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = UIColor.lightGray
        }
    }
    @objc func handleForgetPass() {
        let forgotPasswordVC = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    @objc func handleNewSingup() {
        _ = navigationController?.popViewController(animated: true)
        print("1234")
    }
}
