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
    let user: User
    
    init(_ user: User) {
        self.user = user
        self.realm = try! Realm()
    }
    
    
    func refreshData(completion: () -> Void) {
        APIManager.downloadOrders(forUserID: user.id) {  (orders, error) in
            if let error = error {
                print(error)
            }
            
            if let orders = orders {
                StorageManager.save(orders, forUserWithID: self.user.id)
            }
            
            
            completion()
        }
    }
    
    
    
}