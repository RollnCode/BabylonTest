//
//  SceneCoordinatorError.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation

enum BaseSceneCoordinatorError: LocalizedError {
    case emptyViewController
    case emptyNavigationController
    case canNotToPop
    
    var errorDescription: String? {
        switch self {
        case .emptyViewController:
            return "Unable to find current view controller"
            
        case .emptyNavigationController:
            return "Unable to find current navigation controller"
            
        case .canNotToPop:
            return "Unable to return to previous controller"
        }
    }
    
    var recoverySuggestion: String? {
        return "Something went wrong. App can't navigate to the next or previous screen. Restart the application and try again."
    }
}
