//
//  OrdersDetailTableHeader.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-10-11.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit

class OrdersDetailTableHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    func configure(withTitle title: String, subTitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }
    
    
    override func prepareForReuse() {
        titleLabel.text = ""
        subtitleLabel.text = ""
    }
    
    
    private func setupUI() {
        self.preservesSuperviewLayoutMargins = true;
        self.contentView.preservesSuperviewLayoutMargins = true;
        self.contentView.backgroundColor = UIColor(white: 0.97, alpha: 0.8)
    }
}

