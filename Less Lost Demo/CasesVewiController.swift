////
////  ViewController.swift
////  Less Lost Demo
////
////  Created by Qahtan on 8/4/18.
////  Copyright © 2018 QahtanLab. All rights reserved.
////
//
//import UIKit
//import CoreLocation
//import FirebaseAuth
//import FirebaseDatabase
//
//class CasesVewiController: UITableViewController,CLLocationManagerDelegate {
//
//    let cellId = "cellId"
//    var user: User?
////    var cases = [Cases]()
//
//    var locationManger = CLLocationManager()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchUser()
//        print("super.viewDidLoad()",user)
//        if user?.userType == 0 {
//            print("super.viewDidLoad()",user)
////            cases = []
//        }
//        setupCasesArry()
//
//        tableView.delegate = self
//        tableView.dataSource = self
////        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
//        setupLocation()
//        if Auth.auth().currentUser?.uid == nil  {
//            DispatchQueue.main.async {
//                let singupController = SingupViewController()
//                let nav = UINavigationController(rootViewController: singupController)
//                singupController.cassesViewController = self
////                singupController.location = self.locationManger.location
//                nav.isNavigationBarHidden = true
//                self.present(nav, animated: true, completion: nil)
//            }
//            return
//        }
//        fetchUser()
//    }
//    fileprivate func fetchUser() {
//        guard let uid = Auth.auth().currentUser?.uid else {  return }
//        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
//
//
//            guard let dictuanry = snapshot.value as? [String:Any] else {  return }
//            print("dictuanry",dictuanry)
//            self.user = User(uid: uid, dictionary: dictuanry)
//            self.navigationItem.title = self.user?.username
//            if self.user?.userType == 0 {
//                self.view.backgroundColor = .green
//            }
//            self.tableView.reloadData()
//        }
//
//    }
//    func setupLocation() {
//        view.backgroundColor = .red
//        locationManger.delegate  = self
//        locationManger.desiredAccuracy = kCLLocationAccuracyBest
//        locationManger.requestWhenInUseAuthorization()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(handleSignout))
//        print("locationManger.location",locationManger.location)
//    }
//    func setupCasesArry() {
//
//
//        // Hajjis
////        let users = [User(userType: 3 , id:111122 , email: "cases@gmail.com", uid: "ggokf", location: [19.596786, 43.672013]),
////                     User(userType: 3 , id:111122 , email: "cases@gmail.com", uid: "ggokf", location: [51.512025, -0.137712]),
////                     User(userType: 3 , id:111122 , email: "cases@gmail.com", uid: "ggokf", location: [51.515432, -0.132417]),
////                     User(userType: 3 , id:111122 , email: "cases@gmail.com", uid: "ggokf", location: [51.517258, -0.135302]),
////                     User(userType: 3 , id:111122 , email: "cases@gmail.com", uid: "ggokf", location: [51.519061, -0.130130]),
////                     User(userType: 3 , id:111122 , email: "cases@gmail.com", uid: "ggokf", location: [51.521146, -0.145090]),]
//
////        for i in 0..<5 {
////            let troble = Cases(id: i, user: users[i], title: "Hello\(i)", location: users[i].location)
////            self.cases.append(troble)
////        }
//    }
//
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//////        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
////        cell.backgroundColor = .blue
////        cell.titleLab.text = cases[indexPath.row].title
////        return cell
////    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return cases.count
//        return 1
//    }
//    @objc func handleSignout() {
//        do {
//            try Auth.auth().signOut()
//        }catch let error {
//            print("Field to signout")
//        }
//        let signupViewController = SingupViewController()
//        present(signupViewController, animated: true, completion: nil)
//    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let adminViewController = AdminMapViewController()
////        adminViewController.casees = cases
//        adminViewController.locationManager = locationManger
//        print("locationManger.location",locationManger.location,locationManger)
//        navigationController?.pushViewController(adminViewController, animated: true)
//
////        let mapVC = MapViewController()
////        mapVC.cases = cases[indexPath.row]
////        navigationController?.pushViewController(mapVC, animated: true)
//        print("location", user?.uid)
//    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations")
//    }
//}
//
