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
    let users: Results<User>
    
    init() {
        self.realm = try! Realm()
        self.users = realm.objects(User.self).sorted(byKeyPath: "dateAdded", ascending: false)
        // self.users = realm.objects(User.self).sorted("id", ascending: true)
    }
    
    
    func refreshData(completion: @escaping (_ persistedUsersAvailable: Bool, _ error: Error?) -> Void) {
        APIManager.downloadUsers { (users, error) in
            guard error == nil else {
                completion(self.containsUsers(), error)
                return
            }
            
            guard let users = users else {
                completion(self.containsUsers(), nil)
                return
            }
            
            
            StorageManager.save(users, completion: { 
                self.realm.refresh()
                completion(self.containsUsers(), nil)
            })
        }
    }

    
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    
    func nameOfUser(at index: Int) -> String {
        let user = users[index]
        return user.name
    }
    
    
    func phoneOfUser(at index: Int) -> String {
        let user = users[index]
        return user.phone
    }
    
    
    func pictureURLOfUser(at index: Int) -> String {
        let user = users[index]
        return user.pictureURL
    }
    
    
    func user(at index: Int) -> User {
        return users[index]
    }
    
    
    // MARK: - Helpers
    
    fileprivate func containsUsers() -> Bool {
        return !users.isEmpty
    }
}

