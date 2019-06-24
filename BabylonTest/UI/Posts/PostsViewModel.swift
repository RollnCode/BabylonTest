//
//  PostsViewModel.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class PostsViewModel: ViewModel {

    let posts: BehaviorRelay<[Post]>
    
    override init(services: Services) {
        posts = BehaviorRelay(value: [])
        super.init(services: services)
        reloadData()
    }
    
    func onUserDidSelectPost(_ post: Post) {
        navigateToPostDetails(post)
    }

    func reloadData() {
        services.postsService.postsFeed()
            .do(onError: errorsRelay.accept)
            .catchErrorJustReturn([])
            .filter { !$0.isEmpty }
            .bind(to: posts)
            .disposed(by: disposeBag)
    }

    fileprivate func navigateToPostDetails(_ post: Post) {
        let viewModel = PostDetailViewModel(post: post, services: services)
        let scene = MainFlowScene.postDetail(viewModel)

        services.sceneCoordinator
            .transition(to: scene, type: .push, animated: true)
            .subscribe(onError: errorsRelay.accept)
            .disposed(by: disposeBag)
    }
}
