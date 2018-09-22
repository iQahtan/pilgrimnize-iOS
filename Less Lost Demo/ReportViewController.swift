//
//  ReportViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/7/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import CoreLocation

class ReportViewController: UIViewController {
    
    var user: User?
    var report: Report?
    var theRootViewController:TheRootViewController?
    
    let contactusLab: UILabel = {
        let lab = UILabel()
        let issueTitle = NSMutableAttributedString(string: "Issue Tracking Form", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 26),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)])
        let issueBody = NSMutableAttributedString(string: " \n\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.lightGray])
        issueTitle.append(issueBody)
        lab.attributedText = issueTitle
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
       return lab
    }()
    let phonNumLab: UILabel = {
        let lab = UILabel()
        let phonLab = NSMutableAttributedString(string: "phone number:", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 51, green: 104, blue: 146)])
        
        let astreck = NSMutableAttributedString(string: " *", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor:UIColor.red])
        phonLab.append(astreck)
        lab.attributedText = phonLab
        
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    let textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.borderStyle = .roundedRect
        tv.isEditable = true
        
        return tv
    }()
    let describe: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        lab.text = "Describe the Problem"
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    let reportButton: UIButton = {
        let btn =  UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Report", for: .normal)
        
        btn.addTarget(self, action: #selector(handleReportBtn), for: .touchUpInside)
        let attrubitedString = NSMutableAttributedString(string: "Report", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 224, green: 236, blue: 248)])
        btn.setAttributedTitle(attrubitedString, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        btn.layer.cornerRadius = 5
        return btn
    }()
    let officNumLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.rgb(red: 51, green: 104, blue: 146)
        lab.text = "Enter Office Number Here"
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    let phoneNumber: UITextField = {
       let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        tf.placeholder = "Expmle +96650"
        return tf
    }()
    let officNumber: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "1"
        tf.addTarget(self, action: #selector(hendleFormeValid), for: .editingChanged)
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Report a Problem "
        setupViews()
        view.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        view.hideKeyboardWhenTappedAround()
    }
    func setupViews(){
        view.addSubview(contactusLab)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        contactusLab.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        contactusLab.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        contactusLab.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive  = true
        contactusLab.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        view.addSubview(phonNumLab)
        phonNumLab.leftAnchor.constraint(equalTo: view.leftAnchor,constant:10).isActive = true
        phonNumLab.topAnchor.constraint(equalTo: contactusLab.bottomAnchor,constant:10).isActive = true
        phonNumLab.widthAnchor.constraint(equalToConstant: 150).isActive = true
        phonNumLab.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(phoneNumber)
        phoneNumber.leftAnchor.constraint(equalTo: view.leftAnchor,constant:10).isActive = true
        phoneNumber.topAnchor.constraint(equalTo: phonNumLab.bottomAnchor,constant:10).isActive = true
        phoneNumber.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        phoneNumber.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(officNumLab)
        officNumLab.leftAnchor.constraint(equalTo: view.leftAnchor,constant:10).isActive = true
        officNumLab.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor,constant:10).isActive = true
        officNumLab.widthAnchor.constraint(equalToConstant: 150).isActive = true
        officNumLab.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        view.addSubview(officNumber)
        officNumber.leftAnchor.constraint(equalTo: view.leftAnchor,constant:10).isActive = true
        officNumber.topAnchor.constraint(equalTo: officNumLab.bottomAnchor,constant:10).isActive = true
        officNumber.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        officNumber.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(describe)
        describe.topAnchor.constraint(equalTo: officNumber.bottomAnchor, constant: 10).isActive = true
        describe.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        describe.widthAnchor.constraint(equalToConstant: 170).isActive = true
        describe.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: describe.bottomAnchor, constant: 10).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        view.addSubview(reportButton)
        
        reportButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant:10).isActive = true
        reportButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-10).isActive = true
        reportButton.topAnchor.constraint(equalTo: textView.bottomAnchor,constant:15).isActive = true
        reportButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        phoneNumber.delegate = self
        officNumber.delegate = self
        textView.delegate = self
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let navItemHeight  = self.navigationController?.navigationBar.frame.height else { return}
        let y = navItemHeight + UIApplication.shared.statusBarFrame.height
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                print(view.frame.origin.y)
            if self.view.frame.origin.y == y{
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
            if self.view.frame.origin.y != y{
                self.view.frame.origin.y = y
                print("2",self.view.frame.origin.y)
            }
        }
    }
    func saveReportToDatabase(location:[Double],locationName:String) {
        guard let describtion = textView.text,description != "" else { return }
        guard let uid = theRootViewController?.user?.uid else { return }
        guard let phoneNum = Int(phoneNumber.text!) else { return }
        guard let officNumber = Int(officNumber.text!) else { return}
        // create the report dictonary
        let dictonary:[String:Any] = ["describion": describtion,"phoneNum":phoneNum,"creationDate":Date().timeIntervalSince1970,"active": 0,"officNumber":officNumber,"reportedUserUid":uid,"location":location,"locationName":locationName]
        
        print(dictonary)
        let values = [uid: dictonary]
        /// add the report to database
        let reportsNode = Database.database().reference().child("Reports")
        let reff = reportsNode.childByAutoId()
        let reportUid = reff.description()
        let report = Report( uid: reportUid, dict: values)
        self.theRootViewController?.report = report
        print("report-----",report.description)
        reff.updateChildValues(values) { (error, reff) in
            if let er = error {
                print("Field to Save Report to database", er)
                return
            }
            self.reportButton.isEnabled = false
            self.reportButton.backgroundColor = UIColor.lightGray
            print("Succuffly save the Report to database")
        }
    }
    func getTheLocationName(){
        
        if let reportLocation = theRootViewController?.locationManager?.location {
            let ceo : CLGeocoder = CLGeocoder()
            var locName = ""
            ceo.reverseGeocodeLocation(reportLocation, completionHandler:
                {(placemarks, error) in
                    print(placemarks)
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]
                    print("locationName ", pm)
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        if pm.subLocality != nil {}
                        guard let locationName = pm.subLocality else {  return}
                        locName = locationName
                        var addressString : String = ""
                        print(addressString)
                    }
                    self.saveReportToDatabase(location: [reportLocation.coordinate.latitude,reportLocation.coordinate.longitude], locationName: locName)
                    self.reportButton.isEnabled = false
                    self.reportButton.backgroundColor = UIColor.lightGray
            })
        }else {
            let dict:[String:Any] = ["location": "Unknow","locationName":"Unknow"]
            self.saveReportToDatabase(location: [0,0], locationName: "Unknow")
            self.reportButton.isEnabled = false
            self.reportButton.backgroundColor = UIColor.lightGray
            showAlert()
        }
        /// show alert that conform the report
        
    }
    func showAlert() {
//        let alertController = Uialert
        let alertController = UIAlertController(title: "Thank you", message: "We recive you report and we'll be procces it.", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed default")
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action1)

        self.present(alertController, animated: true, completion: nil)
        
    }
    @objc func handleReportBtn() {
        getTheLocationName()
    }
    func setupNotificationContent(){
        print("setupNotificationContent")
        let content = UNMutableNotificationContent()
        content.title = "New Report add"
        content.subtitle = "vmdkfdkv "
        content.body = "Helllloooooo o o o o o o o  odosmsdmvdsvmosdvomdsvmvsvdsvsdvsdvdsvdsvdsv"
        content.badge = 1
    
        let notifiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let notifiId = "ReportAdd"
        let request = UNNotificationRequest(identifier: notifiId, content: content, trigger: notifiTrigger)
    
        UNUserNotificationCenter.current().add(request) { (erorr) in
            print("Field to load the notification",erorr)
            UNUserNotificationCenter.current().delegate = self
        }
    
    }
    @objc func hendleFormeValid() {
        let isFormValid = phoneNumber.text?.characters.count ?? 0 > 0 && officNumber.text?.characters.count ?? 0 > 0
        print("isFormValid",isFormValid)
        if isFormValid {
            reportButton.isEnabled = true
            reportButton.backgroundColor  = UIColor.rgb(red: 51, green: 104, blue: 146)
        } else {
            reportButton.isEnabled = false
            reportButton.backgroundColor = UIColor.lightGray
        }
    }
}
extension ReportViewController:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        completionHandler([.alert,.sound])
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        let content = response.notification.request.content
    }
    
}
extension ReportViewController : UITextFieldDelegate,UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
