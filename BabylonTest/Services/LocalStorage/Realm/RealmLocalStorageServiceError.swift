//
//  RealmLocalStorageServiceError.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/18/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

enum RealmLocalStorageServiceError: LocalizedError {
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "An unexpected error has occurred"
        }
    }
}
