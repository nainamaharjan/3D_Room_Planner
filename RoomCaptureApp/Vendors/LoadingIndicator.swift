////
////  LoadingIndicator.swift
////  anydone_inbox
////
////  Created by Naina Maharjan on 17/12/2021.
////
//
//import UIKit
//import ImageIO
//
//class LoadingIndicatorView: BaseView {
//    
//    lazy var wrapperView: UIView = {
//        let viw = UIView()
//        return viw
//    }()
//    
//    lazy var loadingIndicatorImage: UIImageView = {
//        let loadingJif = UIImage.gifImageWithName(name: "loader")
//        let img = UIImageView()
//        img.contentMode = .scaleAspectFit
//        img.clipsToBounds = true
//        img.animationImages = loadingJif?.images
//        img.animationDuration = (loadingJif?.duration)! / 4
//        return img
//    }()
//    
//    override func setupView() {
//        self.backgroundColor = .clear
//        self.addSubview(wrapperView)
//        wrapperView.addSubview(loadingIndicatorImage)
//        setupConstraints()
//    }
//    
//    func setupConstraints() {
//        wrapperView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
//        loadingIndicatorImage.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 30, height: 30))
//        loadingIndicatorImage.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
//        loadingIndicatorImage.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor).isActive = true
//        
//    }
//}
//
//class HUD {
//    
//    class func show(_ viewcontroller: UIViewController) {
//        DispatchQueue.main.async {
//            showInStatusBar()
//            viewcontroller.view.presentCustomHud(rootView: viewcontroller)
//        }
//    }
//    
//    class func showInStatusBar() {
//        DispatchQueue.main.async {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        }
//    }
//    
//    class func hideInStatusBar() {
//        DispatchQueue.main.async {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        }
//    }
//    
//    class func hide(_ viewController: UIViewController, success: @escaping(Bool) -> Void) {
//        hideInStatusBar()
//        DispatchQueue.main.async {
//            viewController.view.dismissCustomHud(rootView: viewController)
//            success(true)
//        }
//    }
//}
//
//extension UIView {
//    
//    func presentCustomHud(rootView: UIViewController) {
//        let loadingView = LoadingIndicatorView()
//        loadingView.tag = 999
//        rootView.view.addSubview(loadingView)
//        loadingView.center = rootView.view.center
//        loadingView.loadingIndicatorImage.startAnimating()
//    }
//    
//    func dismissCustomHud(rootView: UIViewController) {
//        DispatchQueue.main.async {
//            rootView.view.isUserInteractionEnabled = true
//            for subView in rootView.view.subviews where subView.tag == 999 {
//                subView.isUserInteractionEnabled = true
//                subView.removeFromSuperview()
//            }
//        }
//    }
//}
