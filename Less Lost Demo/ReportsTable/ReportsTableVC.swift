//
//  ReportsTableVC.swift
//  Less Lost Demo
//
//  Created by Qahtan on 8/14/18.
//  Copyright © 2018 QahtanLab. All rights reserved.
//

import UIKit
class ReportTableVC: UITableViewController {
    let cellId = "cellId"
//    var reports: [Report]?
    var report: Report?
    var theRootViewController : TheRootViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .singleLine
            tableView.register(ReportsCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.backgroundColor = UIColor.rgb(red: 224, green: 236, blue: 248)
        tableView.dataSource  = self
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReportsCell
//        guard let report = report else { return}
        cell.report = theRootViewController?.service?.finshedReprots[indexPath.row]
        return cell
    }
}
extension ReportTableVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rootVC = theRootViewController?.service{
            return rootVC.finshedReprots.count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}
