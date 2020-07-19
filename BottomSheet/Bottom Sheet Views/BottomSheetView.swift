//
//  BottomSheetView.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

/** Represents the state of the displayed sheet and content
 # Can be one of three states:
 - .dismissed: Has been swiped down or closed and is off screen entirely.
 - .collapsed: The sheet occupies approximately the bottom half of the frame.
 - .expanded: The sheet occupies the entire frame minus top padding.
  */
enum BottomSheetState {
    case dismissed, collapsed, expanded
}

protocol SheetViewDelegate: AnyObject {
    
    /// Notifies the delegate that the transition to a new BottomSheetState has completed.
    func didTransition(toState state: BottomSheetState)
}

/// The main UIView subclass that developers should work with when creating a sheet. Be sure to configure your content to insert, and create a BottomSheetConfiguration prior to initializing a BottomSheetView.
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
    
    /// Always create a BottomSheetConfiguration first, then use this init() to create a BottomSheetView
    /// - Parameters:
    ///   - frame: The full area that the sheet view could potentially cover. Usually view.frame if creating in a UIViewController.
    ///   - contentView: A UIView or subclass of UIView that contains your content.
    ///   - configuration: A BottomSheetConfiguration containing options for this Sheet.
    /// - If you would like to be notified of state changes such as the Sheet being dismissed by the user, adopt the SheetViewDelegate and assign the delegate property.
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
