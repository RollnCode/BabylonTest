//
//  PostDetailScreenViewModel.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PostDetailViewModel: ViewModel {

    var postRelay: BehaviorRelay<Post>
    var commentsRelay: BehaviorRelay<[Comment]>
    var authorRelay: BehaviorRelay<User?>
    
    init(post: Post, services: Services) {
        self.postRelay = BehaviorRelay(value: post)
        self.commentsRelay = BehaviorRelay(value: [])
        self.authorRelay = BehaviorRelay(value: nil)
        super.init(services: services)
        
        services.usersService.getAuthorForPost(post).subscribe(onNext: { [authorRelay] (author) in
            authorRelay.accept(author)
        }, onError: errorsRelay.accept).disposed(by: disposeBag)
        
        services.commentsService.getCommentsForPost(post).subscribe(onNext: { [commentsRelay] (comments) in
            commentsRelay.accept(comments)
        }, onError: errorsRelay.accept).disposed(by: disposeBag)
    }

    deinit {
        print("Deinited post detail")
    }
}
