//
//  CGFloat.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
