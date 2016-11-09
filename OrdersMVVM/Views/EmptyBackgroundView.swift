//
//  EmptyBackgroundView.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-10-30.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit

class EmptyBackgroundView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewFromNib()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViewFromNib()
    }

    
    func configureWith(title: String?, subTitle: String?) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }
    
    
    fileprivate func configureViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EmptyBackgroundView", bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        
        contentView.frame = self.bounds
        addSubview(contentView)
    }
}
