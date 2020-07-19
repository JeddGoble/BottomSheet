//
//  BottomSheetModels.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

struct BottomSheetConfiguration {
    
    var initialState: BottomSheetState = .collapsed
    var animationDuration: Double = 0.4
    var animationSpringDamping: CGFloat = 0.6
    var topPadding: CGFloat = 120.0
    var barColor: UIColor = .lightGray
    var title: String?
    var information: String?
    var topTextColor: UIColor = .black
    var gradientColors: (UIColor, UIColor)?
    var overlayColor = UIColor(white: 0.1, alpha: 0.5)
    var shouldEmbedInScroll: Bool = false
    
    // For getting set up quickly
    init(withTitle title: String) {
        self.title = title
        self.gradientColors = (.red, .blue)
    }
    
    init(initialState: BottomSheetState = .collapsed, animationDuration: Double = 0.4, animationSpringDamping: CGFloat = 0.6, topPadding: CGFloat = 120.0, barColor: UIColor = .white, title: String? = nil, information: String? = nil, topTextColor: UIColor = .black, gradientColors: (UIColor, UIColor) = (.white, .white), overlayColor: UIColor  = UIColor(white: 0.1, alpha: 0.5), shouldEmbedInScroll: Bool = false) {
        
        self.initialState = initialState
        self.animationDuration = animationDuration
        self.animationSpringDamping = animationSpringDamping
        self.topPadding = topPadding
        self.barColor = barColor
        self.title = title
        self.information = information
        self.topTextColor = topTextColor
        self.gradientColors = gradientColors
        self.overlayColor = overlayColor
        self.shouldEmbedInScroll = shouldEmbedInScroll
    }
}
