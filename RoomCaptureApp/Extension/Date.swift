//
//  Date.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import Foundation

extension Date {
    public enum DayOfWeek: Int {
        case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    }
    
    func dateString(with timeZone: TimeZone, locale: Locale) -> String {
        if Calendar.current.isDateInToday(self) {
            return "Today"
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        }  else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM YYY"
            formatter.timeZone = timeZone
            formatter.locale = locale
            return formatter.string(from: self)
        }
        
    }
    
    func timeString(with timeZone: TimeZone, locale: Locale) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.string(from: self)
    }
    
    func reduceToMonthDayYear(with timeZone: TimeZone, locale: Locale) -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }
    
    func currentTimeStamp() -> Double {
        return Double(self.timeIntervalSince1970 * 1000)
    }
    
//    func currentTimeStamp() -> Int64 {
//        return Int64(self.timeIntervalSince1970 * 1000)
//    }
    
    static var currentTimeStamp: Int64{
            return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    func adding(hours: Int = 0, minutes: Int = 0, second: Int = 0) -> Date {
        var date = self
        date = Calendar.current.date(byAdding: .hour, value: hours, to: date)!
        date = Calendar.current.date(byAdding: .minute, value: minutes, to: date)!
        date = Calendar.current.date(byAdding: .second, value: hours, to: date)!
        return date
    }
    
    func getDayStartTime() -> Date {
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from:  self)
        let startOfDayTime  = self.adding(hours: -timeComponents.hour!, minutes: -timeComponents.minute!, second: 0)
        return  startOfDayTime.adding(hours: 9, minutes: 0, second: 0)
    }
    
    func getDayEndTime() -> Date {
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from:  self)
        let startOfDayTime  = self.adding(hours: -timeComponents.hour!, minutes: -timeComponents.minute!, second: 0)
        return startOfDayTime.adding(hours: 17, minutes: 0, second: 0)
    }
   
    func getStartOfDatTimeStamp() -> Int64 {
        return Int64(self.getDayStartTime().timeIntervalSince1970 * 1000)
    }
    func getEndOfDatTimeStamp() -> Int64 {
        return Int64(self.getDayEndTime().timeIntervalSince1970 * 1000)
    }
    
    func timeAgo() -> String {
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
//        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        let monthAgo = calendar.date(byAdding: .month, value: -1, to: Date())!
        let yearAgo = calendar.date(byAdding: .year, value: -1, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return diff <= 1 ? "\(diff) second ago" : "\(diff) seconds ago"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return  diff <= 1 ? "\(diff) minute ago" : "\(diff) minutes ago"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return diff <= 1 ? "\(diff) hour ago" : "\(diff) hours ago"
        } else if monthAgo < self { //else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return diff <= 1 ? "yesterday" : "\(diff) days ago"
        } else if yearAgo < self {
            let diff = Calendar.current.dateComponents([.month], from: self, to: Date()).month ?? 0
            return diff == 1 ? "about a month ago" : "\(diff) months ago"
        }
        let diff = Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
        return diff == 1 ? "about a year ago" : "\(diff) years ago"
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)) ~= self
    }
    
    func offset(from: Date) -> (Int, Calendar.Component)? {
        let descendingOrderedComponents = [Calendar.Component.year, .month, .day, .hour, .minute]
        let dateComponents = Calendar.current.dateComponents(Set(descendingOrderedComponents), from: from, to: self)
        let arrayOfTuples = descendingOrderedComponents.map { ($0, dateComponents.value(for: $0)) }
        
        for (component, value) in arrayOfTuples {
            if let value = value, value > 0 {
                return (value, component)
            }
        }
        
        return nil
    }
    
}

extension Date {
    func hasSame(_ components: Calendar.Component..., as date: Date, using calendar: Calendar = .autoupdatingCurrent) -> Bool {
             return components.filter { calendar.component($0, from: date) != calendar.component($0, from: self) }.isEmpty
    }
}
