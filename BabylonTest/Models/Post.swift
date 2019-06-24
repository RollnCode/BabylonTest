//
//  Post.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/16/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

public struct Post: Codable, Equatable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
