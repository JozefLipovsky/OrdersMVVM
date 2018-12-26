//
//  Order.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-09-17.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Order: Object, Mappable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var count: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map: Map) {
        id <- map["id.id"]
        name <- map["name"]
        count <- map["count"]
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
