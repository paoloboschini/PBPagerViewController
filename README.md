PBPagerViewController
====

A Swifty Pager View Controller

![alt tag](https://raw.github.com/paoloboschini/PBPagerViewController/master/screen.gif)

Basic Usage
========

See example project for a demo.

```swift
// In your app delegate

// Create first view controller with title
let vc1 = ExampleViewController()
vc1.view.backgroundColor = UIColor.redColor()
let tuple1: (String, UIViewController) = (vc1.title!, vc1)

// Create second view controller with title
var vc2 = ExampleViewController()
vc2.view.backgroundColor = UIColor.greenColor()
let tuple2: (String, UIViewController) = ("CustomTitle", vc2)

// Create third view controller with title
var vc3 = ExampleViewController()
vc3.view.backgroundColor = UIColor.yellowColor()
let tuple3: (String, UIViewController) = ("Third VC", vc3)

// Create pages
let pages: [(String, UIViewController)] = [tuple1, tuple2, tuple3]

// Create default pager...
let pbPager = PBPagerViewController(pages: pages)

// ...or custom pager
let pbPager = PBPagerViewController(pages: pages, backgroundColor: UIColor.lightGrayColor(), titleColor: UIColor.darkGrayColor(), gradientLocations: [0.2, 0.3, 0.7, 0.8])

// Set navigation controller
let nc = UINavigationController(rootViewController: pbPager)


```
