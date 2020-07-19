//
//  BottomSheetView.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

enum BottomSheetState {
    case dismissed, collapsed, expanded
}

protocol SheetViewDelegate: AnyObject {
    
    func didTransition(toState state: BottomSheetState)
}

class BottomSheetView: UIView {
    
    weak var delegate: SheetViewDelegate?
    
    var contentWidth: CGFloat {
        get {
            return frame.width
        }
    }
    
    private var configuration: BottomSheetConfiguration
    private var currentState: BottomSheetState = .dismissed
    
    private var toggleView: BottomSheetToggleView?
    private var bgOverlayView = UIView()
    
    init(withFrame frame: CGRect, contentView: UIView?, configuration: BottomSheetConfiguration) {
        
        self.configuration = configuration
        
        super.init(frame: frame)
        
        setupBGOverlay()
        setupToggleView(contentView: contentView)
    }
    
    override func didMoveToSuperview() {
        animateToggleView(toState: configuration.initialState)
    }
    
    required init?(coder: NSCoder) {
        configuration = BottomSheetConfiguration()
        toggleView = BottomSheetToggleView(frame: .zero, contentView: nil, configuration: configuration, dragDelegate: nil)
        super.init(coder: coder)
    }
    
    private func setupBGOverlay() {
        bgOverlayView.frame = bounds
        bgOverlayView.backgroundColor = configuration.overlayColor
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        bgOverlayView.addGestureRecognizer(dismissGesture)
        addSubview(bgOverlayView)
    }
    
    private func setupToggleView(contentView: UIView?) {
        
        toggleView = BottomSheetToggleView(frame: bounds, contentView: contentView, configuration: configuration, dragDelegate: self)
        
        guard let toggleView = toggleView else { return }
        addSubview(toggleView)
        animateToggleView(toState: .dismissed, immediate: true)
    }
    
    private func heightForState(_ state: BottomSheetState) -> CGFloat {
        
        switch state {
        case .dismissed:
            return frame.height
        case .collapsed:
            return frame.height / 2.0
        case .expanded:
            return configuration.topPadding
        }
    }
    
    private func animateToggleView(toState: BottomSheetState, immediate: Bool = false) {
        guard let toggleView = toggleView else {
            return
            
        }
        
        let toggleViewOrigin = heightForState(toState)
        var bgColor: UIColor = .clear
        
        switch toState {
        case .dismissed:
            bgColor = .clear
            isUserInteractionEnabled = false
        case .collapsed:
            bgColor = configuration.overlayColor
            isUserInteractionEnabled = true
        case .expanded:
            bgColor = configuration.overlayColor
            isUserInteractionEnabled = true
        }
        
        let transitionTime: Double = immediate ? .zero : configuration.animationDuration
        
        UIView.animate(withDuration: transitionTime, delay: .zero, usingSpringWithDamping: configuration.animationSpringDamping, initialSpringVelocity: .zero, options: .curveEaseOut, animations: { [weak self] in
            
            toggleView.frame.origin = CGPoint(x: .zero, y: toggleViewOrigin)
            self?.bgOverlayView.backgroundColor = bgColor
            
        }) { [weak self] (completed) in
            
            self?.currentState = toState
            self?.delegate?.didTransition(toState: toState)
        }
    }
    
    @objc private func dismiss() {
        animateToggleView(toState: .dismissed)
    }
}

extension BottomSheetView: SheetViewDragDelegate {
    
    func didDragBar(withTouch touch: UITouch, barHeight: CGFloat) {
        guard let toggleView = toggleView else { return }
        
        let point = touch.location(in: self)
        let newToggleViewOrigin = point.y - barHeight / 2.0
        
        toggleView.frame.origin = CGPoint(x: .zero, y: newToggleViewOrigin)
    }
    
    func draggingEnded(lastTouch touch: UITouch, barHeight: CGFloat) {
        
        let point = touch.location(in: self)
        let lastOrigin = point.y - barHeight / 2.0
        
        let distanceToDismiss = abs(lastOrigin - heightForState(.dismissed))
        let distanceToCollapsed = abs(lastOrigin - heightForState(.collapsed))
        let distanceToExpanded = abs(lastOrigin - heightForState(.expanded))
        
        if distanceToDismiss <= distanceToCollapsed && distanceToDismiss <= distanceToExpanded {
            animateToggleView(toState: .dismissed)
        } else if distanceToCollapsed <= distanceToDismiss && distanceToCollapsed <= distanceToExpanded {
            animateToggleView(toState: .collapsed)
        } else if distanceToExpanded <= distanceToDismiss && distanceToExpanded <= distanceToCollapsed {
            animateToggleView(toState: .expanded)
        }
    }
    
    func closeButtonTapped() {
        animateToggleView(toState: .dismissed)
    }
}
