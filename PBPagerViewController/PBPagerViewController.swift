//
//  ViewController.swift
//  PBPagerViewController
//
//  Created by Paolo Boschini on 06/04/15.
//  Copyright (c) 2015 Paolo Boschini. All rights reserved.
//

import UIKit

extension UIViewController : Equatable {}

public func == (v1: UIViewController, v2: UIViewController) -> Bool {
    return v1.isEqual(v2)
}

class PBPagerViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {

    var pageController: UIPageViewController!
    var titleScrollView: UIScrollView!
    var pages: [UIViewController]!
    var titles: [String]!
    var currentIndex: Int!
    var backgroundColor: UIColor!
    var titleColor: UIColor!
    var screenWidth: CGFloat!
    var navbar: UINavigationBar!
    var gradientLocations: [CGFloat]!

    convenience init(pages: [(String, UIViewController)]) {
        let summerSkyColor = UIColor(red: 77/255, green: 174/255, blue: 232/255, alpha: 1)
        let titleColor = UIColor.whiteColor()
        self.init(pages: pages, backgroundColor: summerSkyColor, titleColor: titleColor, gradientLocations: [0, 0.2, 0.8, 1])
    }
    
    init(pages: [(String, UIViewController)], backgroundColor: UIColor, titleColor: UIColor = UIColor.whiteColor(), gradientLocations: [CGFloat]) {
        super.init(nibName: nil, bundle: nil)
        UINavigationBar.appearance().barTintColor = backgroundColor
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        self.titles = pages.map { tuple -> String in tuple.0 }
        self.pages = pages.map { tuple -> UIViewController in tuple.1 }
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.gradientLocations = gradientLocations
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        screenWidth = UIScreen.mainScreen().bounds.size.width
        navbar = navigationController?.navigationBar

        setUpPageViewController()
        setUpTitleScrollView()
        setUpGradients()
        setUpLabels()
        
        let viewControllers = [pages[0]]
        pageController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = find(pages, viewController)
        return index! == 0 ? nil : pages[index! - 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = find(pages, viewController)
        return index! + 1 == pages.count ? nil : pages[index! + 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if completed {
            let index = find(pages, pageController.viewControllers[0] as! UIViewController)
            currentIndex = index
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        currentIndex = currentIndex == nil ? 0 : currentIndex
        let width: Int = Int(view.bounds.size.width)
        let xOffset: Int = Int(scrollView.contentOffset.x)
        let scrolledAmount: Int = xOffset - width + (currentIndex * width)
        titleScrollView.setContentOffset(CGPointMake(CGFloat(scrolledAmount)/2, 0), animated: false)
    }
    
    private func setUpPageViewController() {
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        pageController.delegate = self
        pageController.dataSource = self
        pageController.view.frame = view.bounds
        view.addSubview(pageController.view)
        
        pageController.view.subviews.map { view -> () in
            if view is UIScrollView {
                (view as! UIScrollView).delegate = self
            }
        }
    }
    
    private func setUpTitleScrollView() {
        let rect: CGRect = CGRectMake(0, 0, CGFloat(screenWidth), navbar.frame.size.height)
        titleScrollView = UIScrollView(frame: rect)
        titleScrollView.contentSize = CGSizeMake(screenWidth, navbar.frame.size.height)
        titleScrollView.backgroundColor = backgroundColor
        navigationController?.navigationBar.addSubview(titleScrollView)
    }
    
    var hMaskLayer: CAGradientLayer!
    private func setUpGradients() {
        let stop0 = backgroundColor.colorWithAlphaComponent(1).CGColor
        let stop1 = backgroundColor.colorWithAlphaComponent(0).CGColor
        
        // horizontal gradient (left/right edges)
        hMaskLayer = CAGradientLayer()
        hMaskLayer.opacity = 1
        hMaskLayer.colors = [stop0, stop1, stop1, stop0]
        hMaskLayer.locations = gradientLocations
        hMaskLayer.startPoint = CGPointMake(0, 0)
        hMaskLayer.endPoint = CGPointMake(1.0, 0)
        hMaskLayer.bounds = navbar.bounds
        hMaskLayer.anchorPoint = CGPointZero;

        navbar.layer.addSublayer(hMaskLayer)
        navbar.titleTextAttributes = [NSForegroundColorAttributeName: backgroundColor.colorWithAlphaComponent(0)]
        navbar.backgroundColor = backgroundColor.colorWithAlphaComponent(0)
        navbar.tintColor = titleColor
        navbar.translucent = false
    }
    
    private func setUpLabels() {
        for i in 0..<pages.count {
            let x = i * (Int(screenWidth)/2) + Int(screenWidth/4)
            let label = UILabel(frame: CGRectMake(CGFloat(x), 0, CGFloat(screenWidth/2), navbar.frame.size.height))
            label.textAlignment = NSTextAlignment.Center
            label.text = titles[i]
            label.textColor = titleColor
            label.backgroundColor = backgroundColor
            label.font = UIFont.boldSystemFontOfSize(18)
            titleScrollView.addSubview(label)
        }
    }
}