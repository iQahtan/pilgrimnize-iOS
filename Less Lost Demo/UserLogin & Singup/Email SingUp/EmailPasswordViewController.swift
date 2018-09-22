//
//  EmailPasswordViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/18/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class EmailPasswordViewController: TempletViewController {
    
    var emailUserName: EmailUserNameViewController?
    var userName:String?
    var locationManager:CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        formeTF.isSecureTextEntry = true
    }
    override func handleNextButton() {
        
        self.setupTheLoader()
        guard let email = emailUserName?.email else {  return }
        guard let userName = userName else { return}
        guard let password = formeTF.text else {  return }
        print(email,userName,password)
        print(theRootViewController) // root is nil ???
        var cooardnit = [Double]()
        if let userLocation = locationManager?.location {
            cooardnit = [userLocation.coordinate.latitude,userLocation.coordinate.longitude]
            print("cooardnit",cooardnit)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let er = error {
                print("Field to create user",er.localizedDescription)
                let attributedString = NSMutableAttributedString(string: er.localizedDescription, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light),NSAttributedStringKey.foregroundColor:UIColor.red])
                self.stopAnimating()
                self.errorLabel.attributedText = attributedString
                self.errorLabel.isHidden = false
                return
            }
            self.changeTheLoaderMessage(message: "Authenticating")
            print("Seccussfly create user",authResult?.user.uid)
            //Save User Info to db
            let userType = 2
            let dictionaryValues:[String:Any] = ["username":userName,"location": cooardnit,"userType":userType,"officNumber":1]
            guard let uid = authResult?.user.uid else { return}
            
            let values = [uid:dictionaryValues]
            
            Database.database().reference().child("Users").updateChildValues(values, withCompletionBlock: { (error, reff) in
                if let err = error {
                    print("Field to save user info to database", err)
                }
                self.theRootViewController?.fetchUser()
                print("locationManager- SaveUserToDatabase",cooardnit)
                print("Successfly save user to database")
                self.dismiss(animated: true, completion: nil)
            })
            self.stopAnimating()
        }
        
    }
}
