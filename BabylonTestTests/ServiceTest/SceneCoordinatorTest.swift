//
//  SceneCoordinatorTest.swift
//  BabylonTestTests
//
//  Created by Vitalii Yevtushenko on 6/13/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
@testable import BabylonTest

final class SceneCoordinatorTest: ServiceTest {
    
    var coordinator: SceneCoordinator!
    var services: Services!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        let window = UIWindow()
        coordinator = BaseSceneCoordinator(window: window)
        services = Services(sceneCoordinator: coordinator)
    }
    
    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_successNavigation() {
        let results = testScheduler.createObserver(Void.self)
        
        testScheduler.scheduleAt(0) {
            let postsViewModel = PostsViewModel(services: self.services)
            let postsScene = MainFlowScene.postsScreen(postsViewModel)
            let navigationModel = NavigationControllerModel(services: self.services, root: postsScene)
            let navigationScene = MainFlowScene.navigation(navigationModel)
            self.coordinator.transition(to: navigationScene, type: .root, animated: true).subscribe(results).disposed(by: self.disposeBag)
            
            let mockPost = Post(
                id: -1,
                userId: -1,
                title: "Mock title",
                body: "Mock body"
            )
            
            let postDetailViewModel = PostDetailViewModel(post: mockPost, services: self.services)
            let postDetailScene = MainFlowScene.postDetail(postDetailViewModel)
            self.coordinator.transition(to: postDetailScene, type: .push, animated: false).subscribe(results).disposed(by: self.disposeBag)
            
            self.coordinator.pop(animated: false).subscribe(results).disposed(by: self.disposeBag)
        }
        
        testScheduler.start()
        testScheduler.stop()
        
        let expected: [Recorded<Event<Bool>>] = [
            Recorded.completed(0)
        ]
        
        let mapResult = mapVoidToBool(results.events)
        XCTAssertEqual(mapResult, expected)
        
    }
    
    func test_failureNavigation() {
        
        let results = testScheduler.createObserver(Void.self)
        
        testScheduler.scheduleAt(0) {
            let postsViewModel = PostsViewModel(services: self.services)
            let postsScene = MainFlowScene.postsScreen(postsViewModel)
            self.coordinator.transition(to: postsScene, type: .push, animated: true).subscribe(results).disposed(by: self.disposeBag)
        }
        
        testScheduler.start()
        testScheduler.stop()
        
        let expected: [Recorded<Event<Bool>>] = [
            Recorded.error(0, ServiceError.sceneCoordinator(BaseSceneCoordinatorError.emptyViewController))
        ]
        
        let mapResult = mapVoidToBool(results.events)
        XCTAssertEqual(mapResult, expected)
    }
    
}
