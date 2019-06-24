//
//  NetworkingServiceTest.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/16/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import Moya
@testable import BabylonTest

final class NetworkingServiceTest: ServiceTest {
    
    var networking: NetworkingService!

    override func setUp() {
        super.setUp()
        networking = stubBTRestApiNetworking()
    }
    
    override func tearDown() {
        networking = nil
        super.tearDown()
    }
    
    func test_getPosts() {
        let promise = expectation(description: "Test parsing")
        let result = testScheduler.createObserver([Post].self)
        
        testScheduler.scheduleAt(0) {
            self.networking.getPosts().do(onError: { (error) in
                XCTFail(error.localizedDescription)
            }, onCompleted: {
                promise.fulfill()
            }).subscribe(result).disposed(by: self.disposeBag)
        }
        testScheduler.start()
        wait(for: [promise], timeout: 5)
        testScheduler.stop()
        
        XCTAssert(result.events.first?.value.element?.isEmpty == false)
    }
    
    func test_getUserWithIdentifier() {
        let promise = expectation(description: "Test parsing")
        let result = testScheduler.createObserver([User].self)
        
        testScheduler.scheduleAt(0) {
            self.networking.getUserWithID(1).do(onError: { (error) in
                XCTFail(error.localizedDescription)
            }, onCompleted: {
                promise.fulfill()
            }).subscribe(result).disposed(by: self.disposeBag)
        }
        testScheduler.start()
        wait(for: [promise], timeout: 5)
        testScheduler.stop()
        
        XCTAssert(result.events.first?.value.element?.isEmpty == false)
    }
    
    func test_getCommentsForPost() {
        let promise = expectation(description: "Test parsing")
        let result = testScheduler.createObserver([Comment].self)
        
        testScheduler.scheduleAt(0) {
            self.networking.getCommentsForPostWithID(1).do(onError: { (error) in
                XCTFail(error.localizedDescription)
            }, onCompleted: {
                promise.fulfill()
            }).subscribe(result).disposed(by: self.disposeBag)
        }
        testScheduler.start()
        wait(for: [promise], timeout: 5)
        testScheduler.stop()
        
        XCTAssert(result.events.first?.value.element?.isEmpty == false)
    }
}
