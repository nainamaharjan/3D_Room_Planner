//
//  Logger.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import Foundation

enum LogType: String {
    case error
    case warning
    case success
    case action
    case canceled
}

class Logger {
        
    static func log(_ logType: LogType, _ items: Any?...) {
        items.forEach { (any) in
            if let token = any {
                switch logType {
                case LogType.error:
                    print("\n📕 Error: \(token)", separator: "")
                case LogType.warning:
                    print("\n📙 Warning: \(token)", separator: "")
                case LogType.success:
                    print("\n📗 Success: \(token)", separator: "")
                case LogType.action:
                    print("\n📘 Action: \(token)", separator: "")
                case LogType.canceled:
                    print("\n📓 Cancelled: \(token)", separator: "")
                }
            }
        }
    }
    
}


class CallLogger {
   
    static func log(_ items:Any?...){
        items.forEach { (any) in
            if let token = any {
                print(token, separator:" ")
            }
        }
    }
    
}
