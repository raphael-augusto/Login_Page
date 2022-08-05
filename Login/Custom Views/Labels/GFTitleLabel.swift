//
//  GFTitleLabel.swift
//  Login
//
//  Created by Raphael Augusto on 04/08/22.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(name: String, fontSize: CGFloat) {
        self.init(frame: .zero)
        
        self.textAlignment  = textAlignment
        self.font             = UIFont(name: name, size: fontSize)
    }
    
    
    func configure () {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor                 = .white
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail
    }
}
