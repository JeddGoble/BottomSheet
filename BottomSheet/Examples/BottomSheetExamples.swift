//
//  BottomSheetExamples.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/19/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

class BottomSheetExamples {
    
    class func basicExample(withSize: CGSize) -> UIView {
        let basicView = UIView(frame: CGRect(origin: .zero, size: withSize))
        basicView.backgroundColor = .clear
        
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "I'm Content!"
        titleLabel.textAlignment = .center
        titleLabel.frame.size.width = 200.0
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: basicView.frame.width / 2.0, y: 100.0)
        basicView.addSubview(titleLabel)
        
        return basicView
    }
    
    class func loadFromNibExample(withSize: CGSize) -> UIView? {

        guard let nibExample = Bundle.main.loadNibNamed("ExampleNib", owner: nil, options: nil)?.first as? UIView else { return nil }
        nibExample.frame.size.width = withSize.width
        nibExample.sizeToFit()
        return nibExample
    }
    
    class func collectionViewExample() {
        // Ran out of time!
    }
    
}
