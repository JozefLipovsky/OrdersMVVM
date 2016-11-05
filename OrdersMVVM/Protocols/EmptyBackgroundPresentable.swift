//
//  EmptyBackgroundPresentable.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-11-05.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation

import UIKit
import Foundation

protocol EmptyBackgroundPresentable {
    func addEmptyBackground(withTitle title: String?, subTitle: String?)
    func removeEmptyBackgroundIfPresented()
}


extension EmptyBackgroundPresentable where Self: UITableViewController {
    func addEmptyBackground(withTitle title: String?, subTitle: String?) {
        self.tableView.backgroundView = nil
        
        let emptyBackground = EmptyBackgroundView(frame: self.tableView.frame)
        emptyBackground.configure(withTitle: title, subTitle: subTitle)
        self.tableView.backgroundView = emptyBackground;
    }
    
    func removeEmptyBackgroundIfPresented() {
        if (self.tableView.backgroundView != nil) {
            self.tableView.backgroundView = nil
        }
    }
}

