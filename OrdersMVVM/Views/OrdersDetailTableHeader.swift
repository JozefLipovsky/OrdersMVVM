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
        self.contentView.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
        self.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

