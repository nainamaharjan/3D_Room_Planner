//
//  Validator.swift
//  CleanSwiftTest
//
//  Copyright © 2020 Prabhu Pay. All rights reserved.
//
#if os(iOS)

import Foundation

class Validator {
    
    static func isValidName(_ text: String) -> Bool {
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: text)
    }
    
    static func isValidAddress(_ text : String) -> Bool {
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9 ,.'-()]+$")
        return predicateTest.evaluate(with: text)
    }
    
    static func isValidEmail(_ text : String) -> Bool {
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return predicateTest.evaluate(with: text)
    }
    
    static func isValidPhoneOrLandline(_ text : String) -> Bool {
        if text.count < 10 {
            return isValidLandlineNumber(text)
        } else {
            return isValidPhoneNumber(text)
        }
    }
    
    static func isValidLandlineNumber(_ text : String) -> Bool {
        
        if text.count < 6 { return false }
        let index = text.index(text.startIndex, offsetBy: 0)
        let index1 = text.index(text.startIndex, offsetBy: 1)
        let index3 = text.index(text.startIndex, offsetBy: 3)
        let index4 = text.index(text.startIndex, offsetBy: 4)
        let indexRange1 = index1...index3
        let indexRange2 = index...index1
        let firstThreeDigit = text[indexRange1]
        let firstOneDigit = text[indexRange2]
        
        if( firstThreeDigit == "014" || firstThreeDigit == "016" || firstThreeDigit == "015" || firstThreeDigit == "012") {
            return true
        } else if(firstOneDigit == "0"){
            
            let thirdDigit = text[index3...index4]
            
            if thirdDigit == "4" || thirdDigit == "5" || thirdDigit == "6"  || thirdDigit == "2" {
                return true
            }
            
        }
        
        return false
        
    }
    
    static func isValidPhoneNumber(_ text : String) -> Bool {
        
        if text.count != 10 { return false }
        let index = text.index(text.startIndex, offsetBy: 0)
        let index3 = text.index(text.startIndex, offsetBy: 3)

        let firstThreeDigit = text[index...index3]
        
        switch(firstThreeDigit) {
        case "984", "986", "985", "974", "976", "975", "980", "981", "982", "972", "961", "962", "988":
            return true
        default:
            return false
        }
    }
    
    /// A number is valid if it can be parsed to Integer
    /// - Parameter number: number to validate
    /// - Parameter min: min value
    /// - Parameter max: max value
    static func isValidNumber(_ number : String, min: Int, max: Int) -> Bool {
        
        guard let num = Int(number) else {
            return false
        }
        
        if min != Int.min && min != Int.max {
            
            if Int(num) >= min && Int(num) <= max {
                return true
            } else {
                return false
            }
        }
        
        return true
    }
}

#endif
