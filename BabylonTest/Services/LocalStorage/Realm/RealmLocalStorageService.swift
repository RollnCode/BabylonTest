//
//  RealmLocalStorageService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/17/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

final class RealmLocalStorageService: LocalStorageService {

    internal let configuration: Realm.Configuration
    internal func realm() throws -> Realm {
        return try Realm(configuration: configuration)
    }
    
    internal static let schemaVersions: [UInt64] = [
        2019_17_06_09_00
    ]
    
    // MARK: - Base
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    // MARK: - LocalStorageService
    
    // MARK: Posts

    func save(posts: [Post]) throws {
        let realm = try self.realm()
        let realmPosts: [RealmPost] = posts.map { RealmPost(model: $0) }
        try realm.write { realm.add(realmPosts, update: .modified) }
    }
    
    func postsFeed() -> Observable<[Post]> {
        do {
            let realm = try self.realm()
            let posts = realm.objects(RealmPost.self)
            return Observable.collection(from: posts).map({ (result) -> [Post] in
                return result.map({ $0.model() })
            })
        } catch {
            return Observable.error(error)
        }
    }
    
    // MARK: User
    
    func save(users: [User]) throws {
        let realm = try self.realm()
        let realmUsers: [RealmUser] = users.map { RealmUser(model: $0) }
        try realm.write { realm.add(realmUsers, update: .modified) }
    }
    
    func userWithID(_ identifier: Int) -> Observable<[User]> {
        do {
            let realm = try self.realm()
            let users = realm.objects(RealmUser.self).filter("id == \(identifier)")
            return Observable.collection(from: users).map({ result in
                return result.map({ $0.model() })
            })
        } catch {
            return Observable.error(error)
        }
    }
    
    // MARK: Comments
    
    func save(comments: [Comment]) throws {
        let realm = try self.realm()
        let realmComments: [RealmComment] = comments.map { RealmComment(model: $0) }
        try realm.write { realm.add(realmComments, update: .modified) }
    }
    
    func commentsForPostWithID(_ identifier: Int) -> Observable<[Comment]> {
        do {
            let realm = try self.realm()
            let users = realm.objects(RealmComment.self).filter("postId == \(identifier)")
            return Observable.collection(from: users).map({ result in
                return result.map({ $0.model() })
            })
        } catch {
            return Observable.error(error)
        }
    }
}
