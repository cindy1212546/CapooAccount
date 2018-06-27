//
//  record.swift
//  咖波記帳本
//
//  Created by User07 on 2018/6/23.
//  Copyright © 2018年 Capoo. All rights reserved.
//

import Foundation
import UIKit

struct Lover: Codable {
    var name: String
    var star: String
    var innerBeauty: Bool
    
    static func readRecordsFromFile() -> [Lover]? {
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "lovers"), let lovers = try? propertyDecoder.decode([Lover].self, from: data) {
            return lovers
        } else {
            return nil
        }
    }
    
    static func saveToFile(lovers: [Lover]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(lovers) {
            UserDefaults.standard.set(data, forKey: "lovers")
        }
    }
}
