//
//  LocalStorageService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/16/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

public protocol LocalStorageService {
    func save(posts: [Post]) throws
    func save(users: [User]) throws
    func save(comments: [Comment]) throws
    
    func postsFeed() -> Observable<[Post]>
    func userWithID(_ identifier: Int) -> Observable<[User]>
    func commentsForPostWithID(_ identifier: Int) -> Observable<[Comment]>
}
