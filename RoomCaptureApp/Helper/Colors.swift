//
//  File.swift
//
//
//  Created by Mac on 02/01/2022.
//

import UIKit

public class Colors {
    
    static let PRIMARY = hexStringToUIColor(hex: "7030A0")
    static let secondaryColor = hexStringToUIColor(hex: "F1ECF6")
    static let CASHBACK_GREEN = hexStringToUIColor(hex: "4CAF50")
    static let TEXT_FIELD_UNDERLINE = hexStringToUIColor(hex: "B5B5B5")
    static let PENDING_YELLOW = hexStringToUIColor(hex: "FFCC00")
    static let PRIMARY_LIGHT = hexStringToUIColor(hex: "F8EDED")
//    static let gray = hexStringToUIColor(hex: "D5D5D5")
    static let gray = hexStringToUIColor(hex: "D3D3D3")
    static let backgroundColor = hexStringToUIColor(hex: "FFFFFF")
    static let primaryLight = hexStringToUIColor(hex: "#f8a387")
    static let black = hexStringToUIColor(hex: "000000")


    public init() {
    }
    
    public func getColor(_ colorName: String) -> UIColor{
        switch(colorName){
        case "buttonDisable": return hexStringToUIColor(hex: "BDBDBD")
        case "blue": return hexStringToUIColor(hex: "00466E")
        case "primary": return hexStringToUIColor(hex: "C31B22")
//        case "primary": return hexStringToUIColor(hex: "B71C1C")
        case "gray": return hexStringToUIColor(hex: "#f9f9f9")
        case "grey": return hexStringToUIColor(hex: "#D5D5D5")
        case "darkGray": return hexStringToUIColor(hex: "#434343")
        case "white": return hexStringToUIColor(hex: "#ffffff")
        case "confirmGreen": return hexStringToUIColor(hex: "#8BB80F")
        case "dark_yellow": return hexStringToUIColor(hex: "FFC300")
        case "black_transparent": return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        case "primary_transparent": return UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6)
        case "transparent": return UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.0)
            default:
                return hexStringToUIColor(hex: "B71C1C")
        }
    }
    
    public func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MOVIE COLORS
    static let SEAT_AVAILABLE = hexStringToUIColor(hex: "17C574")
    static let SEAT_SELECTED = hexStringToUIColor(hex: "FFDF60")
    static let SEAT_BOOKED = hexStringToUIColor(hex: "13C1E3")
    static let SEAT_SOLD_OUT = hexStringToUIColor(hex: "C31B22")
    static let SEAT_UNAVAILABLE = hexStringToUIColor(hex: "000000")

    static func hexStringToUIColor(hex:String) -> UIColor {
          var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
          
          if (cString.hasPrefix("#")) {
              cString.remove(at: cString.startIndex)
          }
          
          if ((cString.count) != 6) {
              return UIColor.gray
          }
          
          var rgbValue:UInt64 = 0
          Scanner(string: cString).scanHexInt64(&rgbValue)
          
          return UIColor(
              red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: CGFloat(1.0)
          )
      }
}
