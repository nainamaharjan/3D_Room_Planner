//
//  ToastPosition.swift
//  anydone_inbox
//
//  Created by Nikesh Hyanju on 9/27/21.
//

import Foundation
import UIKit

public enum ToastPos {
    case top
    case center
    case bottom
    
    func centerPoint(forToast toast: UIView, inSuperview superview: UIView) -> CGPoint {
        let topPadding: CGFloat = ToastM.shared.style.verticalPadding + superview.csSafeAreaInsets.top
        let bottomPadding: CGFloat = ToastM.shared.style.verticalPadding + superview.csSafeAreaInsets.bottom
        
        switch self {
        case .top:
            return CGPoint(x: superview.bounds.size.width / 2.0, y: (toast.frame.size.height / 2.0) + topPadding)
        case .center:
            return CGPoint(x: superview.bounds.size.width / 2.0, y: superview.bounds.size.height / 2.0)
        case .bottom:
            return CGPoint(x: superview.bounds.size.width / 2.0, y: (superview.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding)
        }
    }
}
// MARK: - Private UIView Extensions
private extension UIView {
    
    var csSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return .zero
        }
    }
    
}
