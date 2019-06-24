//
//  ServiceErrorTest.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/18/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import XCTest
@testable import BabylonTest

final class ServiceErrorTestCase: XCTestCase {
    
    func test_ServiceErrorText() {
        
        let emptyVCError = BaseSceneCoordinatorError.emptyViewController
        let realmUnknownError = RealmLocalStorageServiceError.unknown
        
        let serviceError1 = ServiceError.sceneCoordinator(emptyVCError)
        let serviceError2 = ServiceError.localStorage(realmUnknownError)
        
        XCTAssertEqual(serviceError1.localizedDescription, emptyVCError.localizedDescription)
        XCTAssertEqual(serviceError2.localizedDescription, realmUnknownError.localizedDescription)
        
    }
}
