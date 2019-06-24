//
//  PostsViewController.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class PostsViewController: ViewController<PostsViewModel> {
    
    let postsTable = UITableView(frame: .zero, style: .plain)
    let postCellIdentifier = "Post cell"
    
    // MARK: - UIViewController
    
    override func loadView() {
        super.loadView()
        
        navigationItem.title = "Posts"
        
        view.addSubview(postsTable)
        postsTable.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        configurePostTable()
    }
    
    // MARK: - Setup/Config
    
    override func setupRx() {
        super.setupRx()

        viewModel.posts.bind(to: postsTable.rx.items(cellIdentifier: postCellIdentifier)) { row, model, cell in
            cell.textLabel?.text = model.title
        }.disposed(by: disposeBag)

        postsTable.rx.modelSelected(Post.self).subscribe(onNext: { [unowned viewModel] (post) in
            viewModel.onUserDidSelectPost(post)
        }).disposed(by: disposeBag)
    }
    
    func configurePostTable() {
        postsTable.register(UITableViewCell.self, forCellReuseIdentifier: postCellIdentifier)
    }
}
