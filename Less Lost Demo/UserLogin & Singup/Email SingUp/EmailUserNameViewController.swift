//
//  EmailUserNameViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/18/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit

class EmailUserNameViewController: TempletViewController {
    
    var singupVC:SingupViewController?
    var email:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(email)
    }
    override func handleNextButton() {
        let emailPasswordViewController = EmailPasswordViewController()
        guard let userName = formeTF.text else {  return}
        emailPasswordViewController.emailUserName = self
        emailPasswordViewController.userName = userName
        navigationController?.pushViewController(emailPasswordViewController, animated: true)
    }
}
