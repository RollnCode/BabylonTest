//
//  PostContentTableViewCell.swift
//  BabylonTest
//
//  Created by Vitalii Yevtushenko on 6/20/19.
//  Copyright © 2019 Vitalii Yevtushenko. All rights reserved.
//

import UIKit
import SnapKit

class PostContentTableViewCell: UITableViewCell {
    
    let bodyContentLabel = UILabel(frame: .zero)
    let totalCommentsLabel = UILabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constructor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        constructor()
    }

    func constructor() {
        contentView.addSubview(bodyContentLabel)
        bodyContentLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8).priority(999)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        bodyContentLabel.numberOfLines = 0
        bodyContentLabel.textAlignment = .left
        
        contentView.addSubview(totalCommentsLabel)
        totalCommentsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bodyContentLabel.snp.bottom).offset(8).priority(999)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8).priority(999)
        }
        totalCommentsLabel.numberOfLines = 1
        totalCommentsLabel.textAlignment = .right
    }

}
