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
    
    
    func refreshData(completion: @escaping (ViewModelDataState) -> Void) {
        APIManager.downloadOrders(forUserID: user.id) { (orders, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            
            guard let orders = orders else {
                completion(.empty)
                return
            }
            
            if orders.isEmpty {
                completion(.empty)
            } else {
                StorageManager.save(orders, forUserWithID: self.user.id)
                completion(.available)
            }
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
