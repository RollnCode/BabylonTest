//
//  Comment.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/19/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

public struct Comment: Codable, Equatable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}
