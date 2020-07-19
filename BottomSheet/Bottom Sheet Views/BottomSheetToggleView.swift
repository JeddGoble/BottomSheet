//
//  BottomSheetOverlayView.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit



class BottomSheetToggleView: UIView {
    
    private let topBarHeight: CGFloat = 80.0
    
    private var topBarView: BottomSheetTopBarView?
    private var contentContainerView: BottomSheetContainerView?
    
    init(frame: CGRect, contentView: UIView?, configuration: BottomSheetConfiguration, dragDelegate: SheetViewDragDelegate?) {
        super.init(frame: frame)
        
        configure(contentView: contentView, configuration: configuration)
        topBarView?.delegate = dragDelegate
    }
    
    required init?(coder: NSCoder) {
        contentContainerView = BottomSheetContainerView(frame: .zero, contentView: nil, configuration: BottomSheetConfiguration())
        super.init(coder: coder)
    }
    
    func configure(contentView: UIView?, configuration: BottomSheetConfiguration) {
        
        guard let topBarView = Bundle(for: BottomSheetTopBarView.self).loadNibNamed(String(describing: BottomSheetTopBarView.self), owner: self, options: nil)?.first as? BottomSheetTopBarView else { return }
        self.topBarView = topBarView
        topBarView.frame = CGRect(origin: .zero, size: CGSize(width: frame.width, height: topBarHeight))
        topBarView.configure(configuration: configuration)
        topBarView.setNeedsLayout()
        addSubview(topBarView)
        
        let contentFrame = CGRect(x: .zero, y: topBarView.frame.height, width: frame.width, height: frame.height - topBarView.frame.height)
        contentContainerView = BottomSheetContainerView(frame: contentFrame, contentView: contentView, configuration: configuration)
        guard let contentContainerView = contentContainerView else { return }
        addSubview(contentContainerView)
    }
    
}
