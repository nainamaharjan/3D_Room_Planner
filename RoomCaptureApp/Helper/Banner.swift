//
//  Banner.swift
//  GIC Insurance
//
//  Created by Naina Maharjan on 08/08/2022.
//

import Foundation
import UIKit

enum BannerStatus: String {
    case success
    case error
    case info
    func value() -> String { return self.rawValue }
}

class Banner {
    /**
     Show a personalized banner.
     - Parameter status: Defines types of banner contains: Succes, Error.
     - Parameter title: Title for the Banner
     - if left empty or nil Default title will be set with respect to status
     - Parameter message: Message for the Banner
     
     - Returns: A new string saying hello to `recipient`.
     */
    static var banner = BRYXBanner()
   
    class func show(status: BannerStatus, title: String?, message: String) {
        DispatchQueue.main.async {
            if title == nil || title == "" {
                var titleText = title
                titleText = status.value()
            }
            banner.dismiss()
            banner = BRYXBanner(title: message, subtitle: nil, image: nil, backgroundColor: getColorFor(status: status))
            banner.minimumHeight = 40.0
            banner.titleLabel.font = UIFont.systemFont(ofSize: 14)
            banner.detailLabel.font = UIFont.systemFont(ofSize: 12)
            banner.dismissesOnTap = true
            banner.position = .top
            banner.show(duration: 3.0)
            
        }
    }
    
    class func getColorFor(status: BannerStatus) -> UIColor {
        switch status {
        case .success:
            return .green
        case .error:
            return .red
        case .info:
            return .purple
        }
    }
    
}
