//
//  LocalStorageServiceTest.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/17/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RealmSwift
import XCTest
import RxTest
import RxSwift
@testable import BabylonTest

final class LocalStorageServiceTest: ServiceTest {
    
    var localStorage: LocalStorageService!
    
    override func setUp() {
        super.setUp()
        localStorage = inMemoryLocalRealmStorage()
    }
    
    func test_saveAndFetchPosts() {
        
        var mockData = [Post]()
        for i in 1...5 {
            let mockPost = Post(
                id: i,
                userId: i,
                title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
            )
            mockData.append(mockPost)
        }
        
        do {
            try self.localStorage.save(posts: mockData)
        } catch {
            XCTFail(error.localizedDescription)
        }
    
        let fetchResult = testScheduler.createObserver([Post].self)
        testScheduler.scheduleAt(10) {
            self.localStorage.postsFeed().subscribe(fetchResult).disposed(by: self.disposeBag)
        }
        
        testScheduler.start()
        testScheduler.stop()
        
        let excpected: [Recorded<Event<[Post]>>] = [
            Recorded.next(10, mockData)
        ]
        
        XCTAssertEqual(excpected, fetchResult.events)
        
    }

    func test_saveAndFetchUsers() {
        
        var mockData = [User]()
        let decoder = JSONDecoder()
        
        for i in 1...5 {
            var mockUser = try! decoder.decode([User].self, from: SampleJsonProvider.user).first!
            mockUser.id = i
            mockData.append(mockUser)
        }
        
        do {
            try self.localStorage.save(users: mockData)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        let fetchResult = testScheduler.createObserver([User].self)
        testScheduler.scheduleAt(10) {
            for i in 1...5 {
                self.localStorage.userWithID(i).subscribe(fetchResult).disposed(by: self.disposeBag)
            }
        }
        
        let notExistFetch = testScheduler.createObserver([User].self)
        testScheduler.scheduleAt(20) {
            self.localStorage.userWithID(1000).subscribe(notExistFetch).disposed(by: self.disposeBag)
        }
        
        testScheduler.start()
        testScheduler.stop()
        
        for event in fetchResult.events {
            if event.value.isCompleted { continue }
            if let user = event.value.element?.first {
                XCTAssert(user.id != -1)
            } else {
                XCTFail("User doesn't exist")
            }
        }
        
        let notExistExpected: [Recorded<Event<[User]>>] = [
            Recorded.next(20, [])
        ]
        
        XCTAssertEqual(notExistFetch.events, notExistExpected)
        
    }
    
    func test_saveAndFetchComments() {
    
        var mockData = [Comment]()
        let mockPostIdentifier = 10
        for i in 1...5 {
            let mockComment = Comment(
                id: i,
                postId: mockPostIdentifier,
                name: "Test name",
                email: "Eliseo@gardner.biz",
                body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
            )
            mockData.append(mockComment)
        }
        
        do {
            try self.localStorage.save(comments: mockData)
        } catch {
            XCTFail(error.localizedDescription)
        }
    
        let fetchResult = testScheduler.createObserver([Comment].self)
        testScheduler.scheduleAt(10) {
            self.localStorage.commentsForPostWithID(mockPostIdentifier) .subscribe(fetchResult).disposed(by: self.disposeBag)
        }
        
        testScheduler.start()
        testScheduler.stop()
        
        let excpected: [Recorded<Event<[Comment]>>] = [
            Recorded.next(10, mockData)
        ]
        
        XCTAssertEqual(excpected, fetchResult.events)
    
    }
}
