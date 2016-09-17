//
//  OrdersDetailViewModel.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-09-17.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import RealmSwift


struct OrdersDetailViewModel {
    private let realm : Realm
    weak var user: User?
    
    init(_ user: User) {
        self.user = user
        self.realm = try! Realm()
    }
    
    
    func refreshOrdersData(completion: () -> Void) {
        guard let user = user else {
            completion()
            return
        }
        
        APIManager.downloadOrders(forUserID: user.id) { (orders, error) in
            
        }
    }

}