//
//  TempletViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/18/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class TempletViewController: UIViewController,NVActivityIndicatorViewable {
    
    var theRootViewController:TheRootViewController?
    
    let loginButton : UIButton = {
        let btn = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: "Sign in", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)]))
        btn.setAttributedTitle(attributedString, for: .normal)
        btn.addTarget(self, action: #selector(handleUserLogin), for: .touchUpInside)
        return btn
    }()
    let infoLab : UILabel = {
        let lab = UILabel()
        let attrubitedString = NSMutableAttributedString(string: "Trouble loggig in?", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColor.lightGray])
        attrubitedString.append(NSMutableAttributedString(string: "\n\n Enter your email and we'll send you a link to get back into your account.", attributes: [NSAttributedStringKey.font :UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.lightGray ]))
        lab.attributedText = attrubitedString
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Back", for: .normal)
        btn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        let attributedString = NSMutableAttributedString(string: "Back", attributes: [NSAttributedStringKey.font
            : UIFont.boldSystemFont(ofSize: 15),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)])
        btn.setAttributedTitle(attributedString, for: .normal)
        return btn
    }()
    let formeTF : UITextField = {
        let tv = UITextField()
        tv.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tv.borderStyle = .roundedRect
        return tv
    }()
    let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        let attributedString = NSMutableAttributedString(string: "Next", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 224, green: 236, blue: 248)])
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        button.backgroundColor = UIColor.lightGray
        button.isEnabled = false
        return button
    }()
    var errorMassage:String?
    
    let errorLabel: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.adjustsFontSizeToFitWidth = true
        lab.textAlignment = .center
        return lab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        view.hideKeyboardWhenTappedAround()
//        setupTheLoader()
        errorLabel.isHidden = true
        setupViews()
    }
    func stopAnimation() {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }
    func setupTheLoader() {
        let type = NVActivityIndicatorType.ballScaleMultiple
        let frame = CGRect(x: 120, y: 120, width: 120, height: 120)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: type, color: .red, padding: 5)
        
        view.addSubview(activityIndicatorView)
//        let size = frame.size
        let size = CGSize(width: 60, height: 60)
//        startAnimating(size, message: "Loading...", messageFont: nil, type: type)
        startAnimating(size, message: "Loading...", messageFont: nil, type: type, color: UIColor.rgb(red: 51, green: 104, blue: 146), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.rgb(red: 224, green: 236, blue: 248), textColor: .lightGray)
//        startAnimating(CGSize(width: 100, height: 100), message: "Hello", messageFont: UIFont.systemFont(ofSize: 12), type: type, color: .blue, padding: 0, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: .white)
    }
    func changeTheLoaderMessage(message:String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("\(message)...")
        }
    }
    func setupViews() {
        view.addSubview(infoLab)
        infoLab.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 8, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 80)
        infoLab.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive  = true
        
        
        view.addSubview(errorLabel)
        errorLabel.anchor(top: infoLab.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 8, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 30)
        
        view.addSubview(formeTF)
        formeTF.anchor(top: errorLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 40)
        
        view.addSubview(nextButton)
        nextButton.anchor(top: formeTF.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 10, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 44)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: nil, left: nil, right: nil, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 20, width: 250, height: 44)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(backButton)
        backButton.anchor(top: nextButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 44)
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    @objc func handleNextButton() {
        
    }
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleUserLogin() {
        let loginViewController = LoginViewController()
        loginViewController.theRootViewController = theRootViewController
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    @objc func hendleFormeValid() {
        let isFormValid = formeTF.text?.characters.count ?? 0 > 0
        
        if isFormValid {
            nextButton.isEnabled = true
            nextButton.backgroundColor  = UIColor.rgb(red: 51, green: 104, blue: 146)
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.lightGray
        }
    }
}
