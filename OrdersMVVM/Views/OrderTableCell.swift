//
//  OrderTableCell.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-09-17.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit

class OrderTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    
    func configure(withName name: String, count: String) {
        nameLabel.text = name
        countLabel.text = count + "x"
    }
    
    
    private func setupUI() {
        self.preservesSuperviewLayoutMargins = true;
        self.contentView.preservesSuperviewLayoutMargins = true;
        self.selectionStyle = .none
    }
}
