//
//  CommentsService.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/19/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import Foundation
import RxSwift

protocol CommentsService {
    func getCommentsForPost(_ post: Post) -> Observable<[Comment]>
}
