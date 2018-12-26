//
//  User.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


// TODO: add date added or something...
class User: Object, Mappable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    @objc dynamic var pictureURL = ""
    @objc dynamic var dateAdded = NSDate()
    let orders = List<Order>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        pictureURL <- map["pictureUrl"]
    }

    
    override static func primaryKey() -> String? {
        return "id"
    }
}
