//
//  ServiceError.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

enum ServiceError: LocalizedError {
    case sceneCoordinator(Error)
    case localStorage(Error)
    
    // MARK: LocalizedError
    
    var localizedDescription: String {
        let nsError = getNSError()
        return nsError.localizedDescription
    }
    
    var recoverySuggestion: String? {
        let nsError = getNSError()
        return nsError.localizedRecoverySuggestion
    }
    
    var failureReason: String? {
        switch self {
        case .sceneCoordinator:
            return "Coordinator"
        case .localStorage:
            return "Local Storage"
        }
    }

}

// MARK: Helpers

extension ServiceError {
    
    private func getNSError() -> NSError {
        switch self {
        case .sceneCoordinator(let error), .localStorage(let error):
            return error as NSError
        }
    }
}
