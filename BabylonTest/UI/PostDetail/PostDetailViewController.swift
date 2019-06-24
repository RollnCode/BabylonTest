//
//  PostDetailViewController.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/14/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PostDetailViewController: ViewController<PostDetailViewModel>, UITableViewDataSource {
    
    let postTableView = UITableView(frame: .zero, style: .grouped)
    let authorCellIdentifier = "Author cell"
    let contentCellIdentifier = "Content cell"
    /**
     One author cell and one content cell. Total: 2
     */
    let numberOfCells = 2
    
    // MARK: - UIViewController

    override func loadView() {
        super.loadView()
        
        view.addSubview(postTableView)
        postTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        configurePostTable()
        
        navigationItem.title = "Post Detail"
    }
    
    // MARK: - Setup/Config
    
    override func setupRx() {
        super.setupRx()
        
        let authorDriver = viewModel.authorRelay.asDriver()
        let postDriver = viewModel.postRelay.asDriver()
        let commentsDriver = viewModel.commentsRelay.asDriver()
        let contentDriver = Driver.combineLatest(authorDriver, postDriver, commentsDriver)
    
        contentDriver.throttle(1).drive(onNext: { [postTableView] (_) in
            postTableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    private func configurePostTable() {
        postTableView.register(UITableViewCell.self, forCellReuseIdentifier: authorCellIdentifier)
        postTableView.register(PostContentTableViewCell.self, forCellReuseIdentifier: contentCellIdentifier)
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.tableFooterView = UIView()
        postTableView.dataSource = self
    }
    
    // MARK: - UITableViewDatasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell {
            switch indexPath.row {
            case 0:
                return authorCellForTableView(tableView, withIndexPath: indexPath)
            case 1:
                return contentCellForTableView(tableView, withIndexPath: indexPath)
            default:
                return UITableViewCell()
            }
        }
        
        return cell
    }
    
    // MARK: Cells
    
    private func authorCellForTableView(_ tableView: UITableView, withIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: authorCellIdentifier, for: indexPath)
        if let user = viewModel.authorRelay.value {
            cell.textLabel?.text = "Author: \(user.username)"
        } else {
            cell.textLabel?.text = "Loading..."
        }
        
        return cell
    }
    
    private func contentCellForTableView(_ tableView: UITableView, withIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contentCellIdentifier, for: indexPath) as! PostContentTableViewCell
        cell.bodyContentLabel.text = viewModel.postRelay.value.body
        cell.totalCommentsLabel.text = "Total comments: \(viewModel.commentsRelay.value.count)"
        
        return cell
    }

}
