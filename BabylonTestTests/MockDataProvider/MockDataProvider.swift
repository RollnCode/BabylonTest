//
//  MockDataProvider.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/21/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
@testable import BabylonTest

struct MockDataProvider {
    
    static let firstPost = Post(
        id: 1,
        userId: 2,
        title: "title",
        body: "body"
    )
    
    static let secondPost = Post(
        id: 2,
        userId: 3,
        title: "title2",
        body: "body2"
    )
    
    static let danielUser = User(
        id: 1,
        name: "Daniel Negreanu",
        username: "Kid Poker",
        email: "dn@danielnegreanu.com",
        phone: "1-(702) 868-9003",
        website: "http://danielnegreanu.com"
    )
    
    static let firstComment = Comment(
        id: 1,
        postId: 1,
        name: "Daniel Negreanu",
        email: "dn@danielnegreanu.com",
        body: "My super body!"
    )
    
    static let secondComment = Comment(
        id: 2,
        postId: 1,
        name: "John Smith",
        email: "js@sydney.com",
        body: "Awesome body!"
    )
}
