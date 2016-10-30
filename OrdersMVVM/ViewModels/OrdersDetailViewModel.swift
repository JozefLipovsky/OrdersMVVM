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
    private let realm: Realm
    let user: User
    
    
    init(_ user: User) {
        self.user = user
        self.realm = try! Realm()
    }
    
    
    func refreshData(completion: @escaping (Error?) -> Void) {
        APIManager.downloadOrders(forUserID: user.id) { (orders, error) in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let orders = orders else {
                completion(nil)
                return
            }
            
            StorageManager.save(orders, forUserWithID: self.user.id, completion: {
                self.realm.refresh() // 
                completion(nil)
            })
        }
    }
    
    
    func numberOfOrders() -> Int {
        return user.orders.count
    }
    
    
    func nameOfOrder(at index: Int) -> String {
        let order = user.orders[index]
        return order.name
    }
    
    
    func countOfOrder(at index: Int) -> String {
        let order = user.orders[index]
        return String(order.count)
    }
}
