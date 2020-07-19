//
//  ViewController.swift
//  BottomSheet
//
//  Created by Jedd Goble on 7/18/20.
//  Copyright © 2020 Jedd Goble. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var toggleButton: RoundedButton!
    
    var sheetView: BottomSheetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onToggleTapped(_ sender: RoundedButton) {
        
        let content = BottomSheetExamples.basicExample(withSize: view.frame.size)
        
        let configuration = BottomSheetConfiguration(initialState: .collapsed,
                                                     title: "Test 1",
                                                     information: "Basic content, laid out in code",
                                                     gradientColors: (.lightGray, .gray))
        
        sheetView = BottomSheetView(withFrame: view.bounds, contentView: content, configuration: configuration)
        
        guard let sheetView = sheetView else { return }
        sheetView.delegate = self
        view.addSubview(sheetView)
    }
    
    @IBAction func onNibButtonTapped(_ sender: RoundedButton) {
        
        let content = BottomSheetExamples.loadFromNibExample(withSize: view.frame.size)
        var configuration = BottomSheetConfiguration(initialState: .collapsed, topPadding: 150.0, barColor: .darkGray, title: "Test 2", information: "Content loaded from nib", topTextColor: .white, gradientColors: (.green, .blue), overlayColor: .clear)
        configuration.shouldEmbedInScroll = true
        
        sheetView = BottomSheetView(withFrame: view.bounds, contentView: content, configuration: configuration)
        
        guard let sheetView = sheetView else { return }
        sheetView.delegate = self
        view.addSubview(sheetView)
    }
    
    @IBAction func emptyExampleTapped(_ sender: RoundedButton) {
        
        // Get your content view ready (UIView or subclass)
        
        // Setting the width and calling sizeToFit() on the content view may be a good idea
        
        // Create a BottomSheetConfiguration, including whether or not you'd like to use your own scrollview or have the framework provide one for you
        
        // Initialize a BottomSheetView with your custom UIView content
        
        // Adopt and set the SheetViewDelegate (optional step)
        
        // Add subview and go! The Sheet will automatically transition to the configuration's initial state once added.
        
    }
}

extension ViewController: SheetViewDelegate {
    
    func didTransition(toState state: BottomSheetState) {
        print("Changed to state: \(state)")
        if state == .dismissed {
            sheetView = nil
        }
    }
    
}
