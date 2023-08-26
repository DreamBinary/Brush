//
//  Date.swift
//  Brush
//
//  Created by cxq on 2023/8/16.
//

import Foundation


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "cn_CN")
        return dateFormatter.string(from: self)
    }
    
    func isFirstOfMonth() -> Bool {
        let components = Calendar.current.dateComponents([.day], from: self)
        return components.day == 1
    }
    
    func monthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = Locale(identifier: "cn_CN")
        return dateFormatter.string(from: self)
    }
    
    func monthNum() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func away(from date: Date) -> Int{
        let components = Calendar.current.dateComponents([.day], from: date, to: self)
        return components.day ?? 0
    }
    
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let formattedDateString = dateFormatter.string(from: self)
        return formattedDateString
    }
}
