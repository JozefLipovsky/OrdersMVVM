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
    
    static func save(_ users:[User], completion: @escaping () -> Void ) {
        DispatchQueue.global(qos: .default).async {
            let realm = try! Realm()
            try! realm.write({
                for user in users where !user.name.isEmpty {
                    realm.add(user, update: true);
                }
            })
            completion()
        }
    }
    
    
    static func save(_ orders:[Order], forUserWithID id: String, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async {
            let realm = try! Realm()
            if let user = realm.object(ofType: User.self, forPrimaryKey: id) {
                try! realm.write({
                    for order in orders {
                        // save or update existing Order object
                        realm.add(order, update: true)
                        if user.orders.filter(NSPredicate(format: "id == %@", order.id)).isEmpty {
                            user.orders.append(order)
                        }
                    }
                })
                completion()
            }
        }
    }
}
