//
//  Constants.swift
//  BigFanzBusiness
//
//  Created by Naina Maharjan on 03/02/2023.
//

import Foundation


func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
