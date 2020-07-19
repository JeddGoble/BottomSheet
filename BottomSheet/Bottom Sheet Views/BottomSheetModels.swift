//
//  BottomSheetModels.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

/// A struct that contains relevant customizations used to configure the BottomSheetView
struct BottomSheetConfiguration {
    
    var initialState: BottomSheetState = .collapsed
    var animationDuration: Double = 0.4
    var animationSpringDamping: CGFloat = 0.6
    var topPadding: CGFloat = 120.0
    var barColor: UIColor = .white
    var title: String?
    var information: String?
    var topTextColor: UIColor = .black
    var gradientColors: (UIColor, UIColor)?
    var overlayColor = UIColor(white: 0.1, alpha: 0.5)
    var shouldEmbedInScroll: Bool = false
    
    /// Use for quick setup.
    static var defaultConfiguration: BottomSheetConfiguration {
        return BottomSheetConfiguration()
    }
    
    /// Customize with a title.
    init(withTitle title: String) {
        self.title = title
    }
    
    /// Initialize a BottomSheetConfiguration to customize your BottomSheetView.
    /// - Parameters:
    ///   - initialState: How the sheetview will be presented on first load (defauilt is .collapsed)
    ///   - animationDuration: Length of the transition to next state (default is 0.4 seconds)
    ///   - animationSpringDamping: Advanced argument for customizing spring dampening between 0 and 1
    ///   - topPadding: Distance from top of view to max height of Sheet
    ///   - barColor: UIColor of the top component (default is white)
    ///   - title: Title text for top bar
    ///   - information: Sub-header text for top bar
    ///   - topTextColor: Color of text in top bar (default is black)
    ///   - gradientColors: Tuple of two UIColors for container's background color transition
    ///   - overlayColor: UIColor to cover views in background. Note: In most cases it is best to adjust opacity. (default is white: 0.1, alpha: 0.5)
    ///   - shouldEmbedInScroll: Set to true to auto-provide a UIScrollView for your content. Note: set to false for any subclass of UIScrollView (such as UITableView) which provides its own scroll functionality.
    
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
