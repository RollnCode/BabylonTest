//
//  RealmComment.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/19/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmComment: Object, RealmModel {

    typealias Model = Comment
    
    @objc dynamic var id: Int = -1
    @objc dynamic var postId: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func update(from model: Comment) {
        id = model.id
        postId = model.postId
        name = model.name
        email = model.email
        body = model.body
    }
    
    func model() -> Comment {
        return Comment(
            id: id,
            postId: postId,
            name: name,
            email: email,
            body: body
        )
    }
}
