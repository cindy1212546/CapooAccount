//
//  RecordTableViewController.swift
//  咖波記帳本
//
//  Created by User07 on 2018/6/23.
//  Copyright © 2018年 Capoo. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {

    var records = [Record]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let records = Record.readRecordsFromFile() {
            self.records = records
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let records = Record.readRecordsFromFile() {
            self.records = records
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
        
        let record = records[indexPath.row]
        cell.dateLabel.text = "\(record.year)\\\(record.month)\\\(record.day)"
        cell.classLabel.text = record.classification
        cell.amountLabel.text = "$" + String(record.amount)
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor(red:1.00, green:0.93, blue:0.86, alpha:1.0)
        }
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        records.remove(at: indexPath.row)
        Record.saveToFile(records: records)
        tableView.reloadData()
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dic = records[indexPath!.row]
            
            let controller = segue.destination as? detailViewController
            controller?.record = dic
            controller?.row = tableView.indexPathForSelectedRow?.row
        }
    }
}
