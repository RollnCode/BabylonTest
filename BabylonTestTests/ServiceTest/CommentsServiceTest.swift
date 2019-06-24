//
//  CommentsServiceTest.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/19/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import XCTest
import RxTest
import RxSwift
import RealmSwift
@testable import BabylonTest

final class CommentsServiceTest: ServiceTest {
    
    var commentsService: CommentsService!
    
    override func setUp() {
        super.setUp()
        
        let networking = stubBTRestApiNetworking()
        let localStorage = inMemoryLocalRealmStorage()
        commentsService = BTCommentsService(networking: networking, localStorage: localStorage)
    }
    
    override func tearDown() {
        commentsService = nil
        super.tearDown()
    }
    
    func test_commentsForPost() {
    
        let promise = expectation(description: "Test comments")
        let result = testScheduler.createObserver([Comment].self)
        var commentsFromService = [Comment]()
        
        testScheduler.scheduleAt(0) {
            self.commentsService.getCommentsForPost(MockDataProvider.firstPost).do(onNext: { (comments) in
                commentsFromService = comments
            }, onError: { (error) in
                XCTFail(error.localizedDescription)
            }, onCompleted: {
                promise.fulfill()
            }).subscribe(result).disposed(by: self.disposeBag)
        }
        testScheduler.start()
        wait(for: [promise], timeout: 5)
        testScheduler.stop()
        
        let expected: [Recorded<Event<[Comment]>>] = [
            Recorded.next(0, []),
            Recorded.next(0, commentsFromService),
            Recorded.completed(0)
        ]
        
        let mockCommets = [
            MockDataProvider.firstComment,
            MockDataProvider.secondComment
        ]
        
        XCTAssertEqual(result.events, expected)
        XCTAssertEqual(commentsFromService.count, 2)
        XCTAssertEqual(commentsFromService, mockCommets)
            
    }
}
