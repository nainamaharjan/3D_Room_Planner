//
//  GetDeviceID.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import UIKit

class DeviceID {
    
    //MARK:  GET Device ID
    static func getdeviceID()->String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
}
