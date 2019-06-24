//
//  RealmUser.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/18/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object, RealmModel {
    
    typealias Model = User
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func update(from model: User) {
        id = model.id
        name = model.name
        username = model.username
        email = model.email
        phone = model.phone
        website = model.website
    }
    
    func model() -> User {
        return User(
            id: id,
            name: name,
            username: username,
            email: email,
            phone: phone,
            website: website
        )
    }
}
