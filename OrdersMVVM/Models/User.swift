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
    dynamic var id = ""
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var pictureURL = ""
    dynamic var dateAdded = NSDate() 
    
    required convenience init?(_ map: Map) {
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
