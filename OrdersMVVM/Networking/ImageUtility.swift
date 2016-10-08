//
//  ImageUtility.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import AlamofireImage

class ImageUtility: NSObject {
    
    private static let baseURL = NSURL(string: "https://inloop-contacts.appspot.com/")
    
    static func setImage(with pictureURL: String, onView imageView: UIImageView) {
        let url = URL(string: pictureURL, relativeTo: baseURL as URL?)
        let absoluteURL = url?.absoluteURL

        if let url = absoluteURL {
            imageView.af_setImage(withURL: url, placeholderImage: UIImage.init(named: "Avatar_placeholder"), filter: AspectScaledToFillSizeFilter(size: imageView.frame.size), imageTransition: .crossDissolve(0.1))
        }
    }
}
