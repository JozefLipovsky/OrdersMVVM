//
//  UsersResponse.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import Foundation
import ObjectMapper

class UsersResponse: Mappable  {
    var userItems: [User]?
    
    
    required convenience init?(map: Map){
        self.init()
    }
    
    
    func mapping(map: Map) {
        userItems <- map["items"]
    }
}
