//
//  AccountController.swift
//  咖波記帳本
//
//  Created by User07 on 2018/6/23.
//  Copyright © 2018年 Capoo. All rights reserved.
//

import UIKit

class AccountController: UIViewController {

    let gifName = ["capoo_heart", "capoo_star", "capoo_money", "capoo_hungry", "capoo_rice", "capoo_write", "peter"]
    var gifCount = 0
    
    var records = [Record]()
    
    @IBOutlet weak var gifImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    
    @IBAction func changeGif(_ sender: Any) {
        if(gifCount == 6) { gifCount = 0 }
        else { gifCount += 1 }
        let gif = "gif/" + gifName[gifCount]
        gifImage.loadGif(name: gif)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let gif = "gif/" + gifName[gifCount]
        gifImage.loadGif(name: gif)
        
        let notiName = Notification.Name("AddRecord")
        NotificationCenter.default.addObserver(self, selector: #selector(addRecordNoti(noti:)), name: notiName, object: nil)
        // Do any additional setup after loading the view.
    }

    @objc func addRecordNoti(noti: Notification) {
        print("ADD")
        if let userInfo = noti.userInfo, let record = userInfo[NotificationObjectKey.record] as? Record {
            records.append(record)
            Record.saveToFile(records: records)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: currentDate)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: currentDate)
        formatter.dateFormat = "MM/dd"
        let day = formatter.string(from: currentDate)
        formatter.dateFormat = "EEE"
        var week = formatter.string(from: currentDate)
        switch week {
        case "Mon":
            week = "週一"
            break
        case "Tue":
            week = "週二"
            break
        case "Wed":
            week = "週三"
            break
        case "Thu":
            week = "週四"
            break
        case "Fri":
            week = "週五"
            break
        case "Sat":
            week = "週六"
            break
        case "Sun":
            week = "週日"
            break
        default:
            break
        }
        date.text = day + "(\(week))"
        
        records = [Record]()
        if let records = Record.readRecordsFromFile() {
            self.records = records
        }
        var monthTotal = 0
        for record in records{
            if(record.year == year && record.month == month){
                monthTotal += record.amount
            }
        }
        monthLabel.text = "$\(monthTotal)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addRecord" {
            let controller = segue.destination as? EditRecordTableViewController
            controller?.add = true
        }
    }
    

}
