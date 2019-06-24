//
//  ServiceTest.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/17/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RealmSwift
import Moya
@testable import BabylonTest

enum EmptyTestError: Error {
    case test
}

class ServiceTest: XCTestCase {

    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        testScheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    //MARK: - Create Services
    
    func stubBTRestApiNetworking() -> BTRestApiNetworkingService {
        return BTRestApiNetworkingService(
            endpointClosure: SampleJsonProvider.successEndpointForTarget,
            stubClosure: MoyaProvider.immediatelyStub
        )
    }
    
    func inMemoryLocalRealmStorage() -> RealmLocalStorageService {
        var inMemoryConfiguration = Realm.Configuration()
        inMemoryConfiguration.inMemoryIdentifier = "Test db in memory"
        inMemoryConfiguration.schemaVersion = RealmLocalStorageService.schemaVersions.last!
        return RealmLocalStorageService(configuration: inMemoryConfiguration)
    }
    
    //MARK: - Helpers
    
    func mapVoidToBool(_ events: [Recorded<Event<Void>>]) -> [Recorded<Event<Bool>>] {
        return events.map { (event) -> Recorded<Event<Bool>> in
            if event.value.isCompleted {
                return Recorded.completed(event.time)
            } else if event.value.element == nil {
                return Recorded.error(event.time, event.value.error ?? EmptyTestError.test)
            } else {
                return Recorded.next(event.time, true)
            }
        }
    }
}
