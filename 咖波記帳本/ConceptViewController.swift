//
//  ConceptViewController.swift
//  咖波記帳本
//
//  Created by User07 on 2018/6/25.
//  Copyright © 2018年 Capoo. All rights reserved.
//

import UIKit
import Charts

class ConceptViewController: UIViewController {

    var records = [Record]()
    var Total = 0
    var s = 1
    
    let classification = ["飲食費", "交通費", "社交費", "化妝、美容", "通訊費", "教育用品", "服飾", "水電費", "房租", "日用品", "旅行費", "其他"]
    var values = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    let colors: [UIColor] = [
        UIColor(red:1.00, green:0.53, blue:0.53, alpha:1.0),
        UIColor(red:1.00, green:0.64, blue:0.53, alpha:1.0),
        UIColor(red:1.00, green:0.73, blue:0.40, alpha:1.0),
        UIColor(red:1.00, green:1.00, blue:0.47, alpha:1.0),
        UIColor(red:0.73, green:1.00, blue:0.40, alpha:1.0),
        UIColor(red:0.40, green:1.00, blue:0.40, alpha:1.0),
        UIColor(red:0.40, green:1.00, blue:1.00, alpha:1.0),
        UIColor(red:0.47, green:0.87, blue:1.00, alpha:1.0),
        UIColor(red:0.60, green:0.73, blue:1.00, alpha:1.0),
        UIColor(red:0.60, green:0.60, blue:1.00, alpha:1.0),
        UIColor(red:0.69, green:0.53, blue:1.00, alpha:1.0),
        UIColor(red:0.89, green:0.56, blue:1.00, alpha:1.0)
    ]
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    @IBOutlet weak var cell1: ConceptView!
    @IBOutlet weak var cell2: ConceptView!
    @IBOutlet weak var cell3: ConceptView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        records = [Record]()
        values = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        if let records = Record.readRecordsFromFile() {
            self.records = records
        }
        Total = 0
        var t = 0
        for record in records{
            Total += record.amount
            t = 0
            for c in classification{
                if(record.classification == c){
                    values[t] += Double(record.amount)
                    break
                }
                t += 1
            }
        }
        totalLabel.text = "$\(Total)"
        
        setChart()
        
        cell()
    }
    
    func setChart() {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<classification.count {
            let dataEntry = PieChartDataEntry()
            dataEntry.y = values[i]
            dataEntry.label = classification[i]
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 0))
        pieChart.data = pieChartData
        
        /*for _ in 0..<dataPoints.count {
         let red = Double(arc4random_uniform(256))
         let green = Double(arc4random_uniform(256))
         let blue = Double(arc4random_uniform(256))
         
         let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
         colors.append(color)
         }*/
        
        pieChartDataSet.colors = colors
        
        pieChart.isUserInteractionEnabled = true
        
        let d = Description()
        d.text = ""
        pieChart.chartDescription = d
        pieChart.centerText = ""
        pieChart.holeRadiusPercent = 0
        pieChart.transparentCircleColor = UIColor.clear
        
        pieChart.legend.enabled = false
        
    }
    
    func cell(){
        var start = 0
        if(s == 2){
            start = 3
        }
        else if(s == 3){
            start = 6
        }
        else if(s == 4){
            start = 9
        }
        var t = Total
        if(Total == 0){
            t = 1
        }
        cell1.color.backgroundColor = colors[start]
        cell1.classLabel.text = classification[start]
        cell1.persentLabel.text = String(format: "%.2f", values[start]/Double(t) * 100) + "%"
        cell1.amountLabel.text = "$\(values[start])"
        
        cell2.color.backgroundColor = colors[start + 1]
        cell2.classLabel.text = classification[start + 1]
        cell2.persentLabel.text = String(format: "%.2f", values[start + 1]/Double(t) * 100) + "%"
        cell2.amountLabel.text = "$\(values[start + 1])"
        
        cell3.color.backgroundColor = colors[start + 2]
        cell3.classLabel.text = classification[start + 2]
        cell3.persentLabel.text = String(format: "%.2f", values[start + 2]/Double(t) * 100) + "%"
        cell3.amountLabel.text = "$\(values[start + 2])"
    }
    
    @IBAction func switchCell(_ sender: Any) {
        if(s < 5){
            s += 1
        }
        else{
            s = 1
        }
        cell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
