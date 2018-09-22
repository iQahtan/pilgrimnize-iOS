//
//  TheRootViewController.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/6/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation


class TheRootViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var user: User?
    let cellId = "cellId"
    var report: Report?
//    var reports = [Report]()
    var locationManager: CLLocationManager?
    var service: Service?
    let loadingPlaceholderView = LoadingPlaceholderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupLocationManager()
        self.setupCollectionView()
        
        if Auth.auth().currentUser?.uid == nil  {
            DispatchQueue.main.async {
                let singupController = SingupViewController()
                singupController.theRootViewController = self
                let nav = UINavigationController(rootViewController: singupController)
                nav.isNavigationBarHidden = true
                self.present(nav, animated: true, completion: nil)
            }
            self.setupLoadingPlaceholderView()
            loadingPlaceholderView.cover(view)
            self.dismiss(animated: true, completion: nil)
            return
        }
        service = Service()
        service?.listenToChanging()
        service?.theRootViewController = self
        setupLoadingPlaceholderView()
        loadingPlaceholderView.cover(view)
        fetchUser()
        print("viewDidLoad()")
        guard let user = user else {  return}
        self.service?.fetchReports(user: user)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    fileprivate func setupNavigationBar() {
        
//        self.navigationController?.navigationBar.tintColor =
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 47, green: 128, blue: 197)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18),NSAttributedStringKey.foregroundColor:UIColor.white]
//        let navBar = self.navigationController?.navigationBar
//        navBar?.backgroundColor = .red
//        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(handleSignout))
//    navigationBarAppearace.tintColor  = .white
//    navigationBarAppearace.backgroundColor = UIColor.rgb(red: 178, green: 194, blue: 211)
    }
    fileprivate func setupLocationManager() {
    locationManager = CLLocationManager()
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    locationManager?.requestAlwaysAuthorization()
    locationManager?.distanceFilter = 50
//    locationManager?.startUpdatingLocation()
    locationManager?.delegate = self
    locationManager?.allowsBackgroundLocationUpdates = true
    locationManager?.delegate = self
    }
    private func setupLoadingPlaceholderView() {
        loadingPlaceholderView.gradientColor = .white
        loadingPlaceholderView.backgroundColor = .white
    }
    func setupCollectionView(){
        collectionView?.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 18, left: 18, bottom: 0, right: 18)
    }
    @objc func handleSignout() {
        do {
            try Auth.auth().signOut()
        }catch let error {
            print("Field to signout")
        }
        
        let loginViewController = SingupViewController()
        let navController = UINavigationController(rootViewController: loginViewController)
        loginViewController.theRootViewController = self
        navController.isNavigationBarHidden = true
        present(navController, animated: true, completion: nil)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if user?.userType == 2 {
            return 2
        } else if user?.userType == 0 {
            return 2
//            return (service?.reports.count)!
        }else if user?.userType == 1 {
            
            if (service?.reports.isEmpty)! {
                return 0
            }
            return (service?.reports.count)!
        }
        
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let titles = ["Monitoring","Complete"]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCollectionViewCell
            if user != nil && user?.userType == 1 {
                cell.report = service?.reports[indexPath.row]
            } else if user?.userType == 0 {
                cell.report = nil
                cell.discription.text = titles[indexPath.item]
        }
        cell.backgroundColor = .white
            return cell
    }
      func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else {  return }
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictuanry = snapshot.value as? [String:Any] else {  return }
    
            self.user = User(uid: uid, dictionary: dictuanry)
            
            self.collectionView?.reloadData()
            self.locationManager?.startUpdatingLocation()
            self.navigationItem.title = self.user?.username
//            self.fetchReport()
            guard let user = self.user else{ return}
            print("U",user)
            self.service?.fetchReports(user: user)
            if self.user?.userType == 0 {
                self.service?.fetchUsers(user: user)
            }
//            self.collectionView?.reloadData()
            self.loadingPlaceholderView.uncover()

        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = user else { return}
        
        if user.userType == 0  {
            if indexPath.item == 0 {
                let mapViewController = MapViewController()
                mapViewController.user = user
                mapViewController.theRootViewController = self
                mapViewController.locationManager = self.locationManager
                navigationController?.pushViewController(mapViewController, animated: true)
                print("Admin and employ only")
            }else if indexPath.item == 1 {
                let tableViewController = ReportTableVC()
                tableViewController.theRootViewController = self
                navigationController?.pushViewController(tableViewController, animated: true)
//                tableViewController.report = service?.finshedReprots[indexPath.row]
                print("Table table table tab table ")
            }
        }else if user.userType == 1 {
            print("indexPath.item",indexPath.item)
            let mapViewController = MapViewController()
            mapViewController.user = user
            mapViewController.reportIndex = indexPath.item
            mapViewController.locationManager = self.locationManager
            mapViewController.theRootViewController = self
            mapViewController.report = service?.reports[indexPath.row]
            
            
            
            navigationController?.pushViewController(mapViewController, animated: true)
        } else {
            
            let reportViewController = ReportViewController()
            //            reportViewController.user = user
            reportViewController.theRootViewController = self
            navigationController?.pushViewController(reportViewController, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 36
        return CGSize(width: width, height: width)
    }
}
extension TheRootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        
        print("User updata location ")
        
        guard let userLocation = locations.last else { return }
        guard let uid = user?.uid else { return}
        
       user?.location = [userLocation.coordinate.latitude,userLocation.coordinate.longitude]
        let dict :[String:Any] = ["location":[userLocation.coordinate.latitude,userLocation.coordinate.longitude]]
        Database.database().reference().child("Users").child(uid).updateChildValues(dict)
    }
}
