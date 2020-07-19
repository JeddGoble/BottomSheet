//
//  RoundedButton.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    var inset: CGFloat = 10.0
    
    override func didMoveToSuperview() {
        configure()
    }
    
    func configure(text: String? = nil, buttonColor: UIColor = .red) {
        
        if let text = text {
            titleLabel?.text = text
        }
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        backgroundColor = buttonColor
        
        contentEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2.0
        clipsToBounds = true
    }
}
