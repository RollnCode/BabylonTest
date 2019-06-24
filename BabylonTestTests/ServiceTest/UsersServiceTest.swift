//
//  UsersServiceTest.swift
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

final class UsersServiceTest: ServiceTest {
    
    var usersService: UsersService!
    
    override func setUp() {
        super.setUp()
        
        let networking = stubBTRestApiNetworking()
        let localStorage = inMemoryLocalRealmStorage()
        usersService = BTUsersService(networking: networking, localStorage: localStorage)
    }
    
    override func tearDown() {
        usersService = nil
        super.tearDown()
    }
    
    func test_getAutorForPosts() {
        
        let promise = expectation(description: "Test get user for service")
        let result = testScheduler.createObserver(User?.self)
        var userFromService: User?
        
        testScheduler.scheduleAt(0) {
            self.usersService.getAuthorForPost(MockDataProvider.firstPost).do(onNext: { (maybeUser) in
                userFromService = maybeUser
            }, onError: { (error) in
                XCTFail(error.localizedDescription)
            }, onCompleted: {
                promise.fulfill()
            }).subscribe(result).disposed(by: self.disposeBag)
        }
        
        testScheduler.start()
        wait(for: [promise], timeout: 5)
        testScheduler.stop()
        
        let expected: [Recorded<Event<User?>>] = [
            Recorded.next(0, nil),
            Recorded.next(0, userFromService),
            Recorded.completed(0)
        ]
    
        XCTAssertEqual(result.events, expected)
        XCTAssertNotNil(userFromService)
        XCTAssertEqual(userFromService!, MockDataProvider.danielUser)
        
    }
}
