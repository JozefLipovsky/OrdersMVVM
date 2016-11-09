//
//  UserTableCell.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-21.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    func configureWith(name: String, phone: String, pictureURL: String) {
        userNameLabel.text = name
        phoneNumberLabel.text = phone
        ImageUtility.setImage(with: pictureURL, onView: avatarImageView)
    }
    
    
    override func prepareForReuse() {
        avatarImageView.image = UIImage.init(named: "Avatar_placeholder")
    }
    
    
    fileprivate func setupUI() {
        self.preservesSuperviewLayoutMargins = true;
        self.contentView.preservesSuperviewLayoutMargins = true;
    }
}
