# BottomSheet

Building a BottomSheet Component: Code Project for DoorDash iOS Developer Applicant [Jedd Goble](https://www.linkedin.com/in/jeddgoble/)


## Super Quick Start

```swift
        let config = BottomSheetConfiguration(withTitle: "Hey it works!")
        let sheet = BottomSheetView(withFrame: view.bounds, contentView: nil, configuration: config)
        view.addSubview(sheet)
```

## Customization

```swift
    @IBAction func emptyExampleTapped(_ sender: RoundedButton) {
        
        // Get your content view ready (UIView or subclass)
        let myContent = CustomView(frame: view.bounds)

        // Setting the width and calling sizeToFit() on the content view may be a good idea
        myContent.sizeToFit()

        // Create a BottomSheetConfiguration, including whether or not you'd like to use your own scrollview or have the framework provide one for you
        let configuration = BottomSheetConfiguration(initialState: .collapsed, topPadding: 150.0, barColor: .darkGray, title: "Test", information: "This is a test of the emergency broadcast system", topTextColor: .red, gradientColors: (.green, .blue), overlayColor: .clear, shouldEmbedInScroll: true)
        
        // Initialize a BottomSheetView with your custom UIView content
        let sheetView = BottomSheetView(withFrame: view.bounds, contentView: myContent, configuration: configuration)

        // Adopt and set the SheetViewDelegate (optional step)
        sheetView.delegate = self
        
        // Add subview and go! The Sheet will automatically transition to the configuration's initial state once added.
        view.addSubview(sheetView)
        
    }
```