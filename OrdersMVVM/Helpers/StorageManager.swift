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
        });
    }
}
