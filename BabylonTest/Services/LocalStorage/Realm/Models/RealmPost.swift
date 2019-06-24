//
//  RealmPost.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/17/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPost: Object, RealmModel {

    typealias Model = Post

    @objc dynamic var id: Int = -1
    @objc dynamic var userId: Int = -1
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func update(from model: Post) {
        id = model.id
        userId = model.userId
        title = model.title
        body = model.body
    }
    
    func model() -> Post {
        return Post(
            id: id,
            userId: userId,
            title: title,
            body: body
        )
    }
}
