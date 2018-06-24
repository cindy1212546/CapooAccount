//
//  record.swift
//  咖波記帳本
//
//  Created by User07 on 2018/6/23.
//  Copyright © 2018年 Capoo. All rights reserved.
//

import Foundation
import UIKit

struct Record: Codable {
    var year: String
    var month: String
    var day: String
    var week: String
    var amount: Int
    var classification: String
    var note: String
    
    static func readRecordsFromFile() -> [Record]? {
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "records"), let records = try? propertyDecoder.decode([Record].self, from: data) {
            return records
        } else {
            return nil
        }
    }
    
    static func saveToFile(records: [Record]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(records) {
            UserDefaults.standard.set(data, forKey: "records")
        }
    }
}
