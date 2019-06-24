//
//  PostsServiceTest.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/18/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import XCTest
import RxTest
import RxSwift
import RealmSwift
import Moya

@testable import BabylonTest

final class PostsServiceTest: ServiceTest {
    
    var postsService: PostsService!
    
    override func setUp() {
        super.setUp()
        
        let networking = stubBTRestApiNetworking()
        let localStorage = inMemoryLocalRealmStorage()
        postsService = BTPostsService(networking: networking, localStorage: localStorage)
    }
    
    override func tearDown() {
        postsService = nil
        super.tearDown()
    }
    
    func test_postsFeed() {
        let promise = expectation(description: "Test posts feed")
        let result = testScheduler.createObserver([Post].self)
        var postsFromService = [Post]()
        
        testScheduler.scheduleAt(0) {
            self.postsService.postsFeed().do(onNext: { (posts) in
                postsFromService = posts
            }, onError: { (error) in
                XCTFail(error.localizedDescription)
            }, onCompleted: {
                promise.fulfill()
            }).subscribe(result).disposed(by: self.disposeBag)
        }
        testScheduler.start()
        wait(for: [promise], timeout: 5)
        testScheduler.stop()
        
        let expected: [Recorded<Event<[Post]>>] = [
            Recorded.next(0, []),
            Recorded.next(0, postsFromService),
            Recorded.completed(0)
        ]
    
        let mockPosts = [
            MockDataProvider.firstPost,
            MockDataProvider.secondPost
        ]
        
        XCTAssertEqual(result.events, expected)
        XCTAssertEqual(postsFromService.count, 2)
        XCTAssertEqual(postsFromService, mockPosts)
    }
}
