//
//  DateConverter.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import Foundation

struct DateConverter {
    
    static func getReadableDateRelative(timeStamp: Int64, format: String) -> String? {
        let date =  Date(timeIntervalSince1970: Double(timeStamp / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  format
        return dateFormatter.string(from: date)
    }
    
    static func getReadableDate(timeStamp: Int64, format: String) -> String? {
        let date =  Date(timeIntervalSince1970: Double(timeStamp / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func getReadableDateFromDate(date: Date, format: String) -> String? {
        let date =  date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}

struct DateFormats {
    static let yearMonthDaySlash = "yyyy/MM/dd"
    static let DDMMYYY = "dd, MMM yyyy"
    static let DDMMYYTIME = "dd MMM, yyyy hh:mm a"
    static let MMMDDYYYY = "MMM dd, yyyy"
    static let invoicePaidDate = "E, d MMM yyyy h:mm a"
    static let DateFromPicker = "yyyy-MM-dd HH:mm:ss Z"
    static let DefaultDatePicker = "dd/MM/yy"
    static let DateOnly = "dd"
    static let DateMonth = "dd MMM"
    static let MonthYear = "MMM yyyy"
    static let MonthOnly = "MMM"
    static let TimeOnly = "h:mm a"
    static let DateTime = "dd MMM h:mm a"
    static let MinSeconds = "mm:ss"
    static let CallHistoryTimeFormat = "dd MMM, yyyy - hh:mm a"
}
