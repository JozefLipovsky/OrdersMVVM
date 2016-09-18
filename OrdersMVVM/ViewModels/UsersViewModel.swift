//
//  UsersViewModel.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import RealmSwift

struct UsersViewModel {
    private let realm : Realm
    let users: Results<User>?
    
    init() {
        self.realm = try! Realm()
        self.users = realm.objects(User.self).sorted("dateAdded", ascending: false)
        // self.users = realm.objects(User.self).sorted("id", ascending: true)
    }
    
    
    func refreshData(completion: () -> Void) {
        APIManager.downloadUsers { (users, error) in
            if let users = users {
                StorageManager.save(users)
            }
            
            if let downloadError = error {
                // return error in completion block for alert...
                print(downloadError)
            }
            
            completion()
        }
    }
    
    
    func numberOfUsers() -> Int {
        return users!.count
    }
    
    
    func nameOfUser(at index: Int) -> String {
        let user = users![index]
        return user.name
    }
    
    
    func phoneOfUser(at index: Int) -> String {
        let user = users![index]
        return user.phone
    }
    
    
    func pictureURLOfUser(at index: Int) -> String {
        let user = users![index]
        return user.pictureURL
    }
    
    
    func user(at index: Int) -> User {
        return users![index]
    }
}

