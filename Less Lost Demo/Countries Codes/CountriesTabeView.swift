//
//  CountriesTabeView.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/28/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
class CountriesTableView: UITableViewController {
    let cellId = "cellId"
    
    let countryPhoneCodeAndName = CountryPhoneCodeAndName()
    var signupVC : SingupViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPhoneCodeAndName.getCountryName()
        print(countryPhoneCodeAndName.countryWithCode.count,countryPhoneCodeAndName.countryDictionary.count)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
//        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dissmisTable))
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    @objc func dissmisTable() {
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryPhoneCodeAndName.countryDictionary.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        
        cell.countryName.text = countryPhoneCodeAndName.countryWithCode[indexPath.row].countryName
        cell.countryCode.text = "+\(countryPhoneCodeAndName.countryWithCode[indexPath.row].countryCode)"
//        cell.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.signupVC?.phoneKey.setTitle("+\(countryPhoneCodeAndName.countryWithCode[indexPath.row].countryCode)", for: .normal)
        
        
    }
}
