//
//  detailViewController.swift
//  咖波記帳本
//
//  Created by User07 on 2018/6/24.
//  Copyright © 2018年 Capoo. All rights reserved.
//

import UIKit
import GameplayKit

class detailViewController: UIViewController {

    var record: Record!
    var row: Int!
    var records = [Record]()
    let imgName = ["capoo_write1", "capoo_write2", "love"]
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var noteLabel: UITextView!
    @IBOutlet weak var sticker: UIImageView!
    
    @objc func editRecordNoti(noti: Notification) {
        print("Edit")
        if let userInfo = noti.userInfo, let record = userInfo[NotificationObjectKey.record] as? Record {
            records[row] = record
            Record.saveToFile(records: records)
            dateLabel.text = "\(record.year)\\\(record.month)\\\(record.day)"
            classLabel.text = record.classification
            amountLabel.text = "$" + String(record.amount)
            noteLabel.text = record.note
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomDistribution = GKRandomDistribution(lowestValue: 0, highestValue: imgName.count  -  1)
        let f = randomDistribution.nextInt()
        sticker.image = UIImage(named: imgName[f])
        
        dateLabel.text = "\(record.year)\\\(record.month)\\\(record.day)"
        classLabel.text = record.classification
        amountLabel.text = "$" + String(record.amount)
        noteLabel.text = record.note
        
        if let records = Record.readRecordsFromFile() {
            self.records = records
        }
        
        let notiName = Notification.Name("EditRecord")
        NotificationCenter.default.addObserver(self, selector: #selector(editRecordNoti(noti:)), name: notiName, object: nil)
        // Do any additional setup after loading the view.
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
        /*if let row = tableView.indexPathForSelectedRow?.row {
         let record = records[row]
         let controller = segue.destination as? EditRecordTableViewController
         controller?.record =  record
         }*/
        if segue.identifier == "editRecord" {
            let controller = segue.destination as? EditRecordTableViewController
            controller?.record =  record
        }
    }
}
