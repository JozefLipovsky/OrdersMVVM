//
//  ProgressOverlayView.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-28.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import UIKit

class ProgressOverlayView {
    static var currentOverlayView: UIView?
    
    
    static func show() {
        guard let mainWindow = UIApplication.sharedApplication().keyWindow else { return }
        
        dismiss()
        
        let overlayView = UIView(frame: mainWindow.frame)
        overlayView.center = mainWindow.center
        overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicator.center = overlayView.center
        activityIndicator.startAnimating()
        
        overlayView.addSubview(activityIndicator)
        mainWindow.addSubview(overlayView)
        
        currentOverlayView = overlayView
    }
    
    
    static func dismiss() {
        guard currentOverlayView != nil else { return }
        currentOverlayView?.removeFromSuperview()
        currentOverlayView = nil
    }
    
}