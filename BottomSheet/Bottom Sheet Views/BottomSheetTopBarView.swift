//
//  BottomSheetTopBarView.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

protocol SheetViewDragDelegate: AnyObject {
    func didDragBar(withTouch touch: UITouch, barHeight: CGFloat)
    func draggingEnded(lastTouch touch: UITouch, barHeight: CGFloat)
    func closeButtonTapped()
}

class BottomSheetTopBarView: UIView {
    
    weak var delegate: SheetViewDragDelegate?
    
    private var topCornerRadius: CGFloat = 5.0
    private var closeAction: (() -> Void)? = nil
    
    @IBOutlet weak private var lineView: UIImageView! {
        didSet {
            lineView.layer.cornerRadius = lineView.frame.height / 2.0
            lineView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var informationLabel: UILabel!
    
    func configure(configuration: BottomSheetConfiguration) {
        
        titleLabel.text = configuration.title
        titleLabel.textColor = configuration.topTextColor
        informationLabel.text = configuration.information
        informationLabel.textColor = configuration.topTextColor
        backgroundColor = configuration.barColor
        
        let shape = CAShapeLayer()
        shape.bounds = frame
        shape.position = center
        shape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: topCornerRadius, height: topCornerRadius)).cgPath
        layer.mask = shape
        
    }
    
    @IBAction func onCloseTapped(_ sender: UIButton) {
        delegate?.closeButtonTapped()
    }
}

extension BottomSheetTopBarView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        delegate?.didDragBar(withTouch: touch, barHeight: frame.height)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else { return }
        delegate?.didDragBar(withTouch: touch, barHeight: frame.height)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first else { return }
        delegate?.draggingEnded(lastTouch: touch, barHeight: frame.height)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        guard let touch = touches.first else { return }
        delegate?.draggingEnded(lastTouch: touch, barHeight: frame.height)
    }
}
