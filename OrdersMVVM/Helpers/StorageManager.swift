//
//  StorageManager.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import RealmSwift

class StorageManager: NSObject {
    
    static func save(users:[User]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let realm = try! Realm()
            try! realm.write({ 
                for user in users where !user.name.isEmpty {
                    realm.add(user, update: true);
                }
            })
        })
    }
    
    
    static func save(orders:[Order], forUserWithID id: String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let realm = try! Realm()
            if let user = realm.objectForPrimaryKey(User.self, key: id) {
                try! realm.write({
                    for order in orders {
                        // save or update existing Order object
                        realm.add(order, update: true)
                        
                        // if User's orders list doesn't contain this Order yet add object to the list
                        if let fillteredResults:Results<Order> = user.orders.filter(NSPredicate(format: "id == %@", order.id)) where fillteredResults.isEmpty {
                            user.orders.append(order)
                        }
                    }
                })
            }
        })
    }
}
