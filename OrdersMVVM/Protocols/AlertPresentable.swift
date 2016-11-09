//
//  AlertPresentable.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-11-05.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit
import Foundation

protocol AlertPresentable {
    func showAlert(title: String?, message: String?)
}


extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.present(alert, animated: true, completion: nil)
        }
    }
}


