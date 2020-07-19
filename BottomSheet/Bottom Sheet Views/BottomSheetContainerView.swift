//
//  BottomSheetContainerView.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

class BottomSheetContainerView: UIView {
    
    private var gradientColors: (UIColor, UIColor) = (.red, .blue)
    
    private var scrollingSubview: UIScrollView?
    
    init(frame: CGRect, contentView: UIView?, configuration: BottomSheetConfiguration) {
        
        super.init(frame: frame)
        
        configure(contentView: contentView, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure(contentView: UIView? = nil, configuration: BottomSheetConfiguration) {
        
        if let configurationColors = configuration.gradientColors {
            gradientColors = configurationColors
        }
        
        guard let contentView = contentView else { return }
        
        if configuration.shouldEmbedInScroll {
            let scrollViewFrame = CGRect(origin: .zero, size: frame.size)
            let scrollingSubview = UIScrollView(frame: scrollViewFrame)
            self.scrollingSubview = scrollingSubview
            addSubview(scrollingSubview)
            scrollingSubview.contentSize = CGSize(width: contentView.frame.size.width,  height: contentView.frame.size.height + configuration.topPadding)
            scrollingSubview.addSubview(contentView)
        } else {
            addSubview(contentView)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let colors = [gradientColors.0.cgColor, gradientColors.1.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else { return }
        
        let start = CGPoint.zero
        let end = CGPoint(x: .zero, y: bounds.height)
        context.drawLinearGradient(gradient, start: start, end: end, options: [])
    }
    
}
