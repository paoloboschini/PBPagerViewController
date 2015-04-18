//
//  AppDelegate.swift
//  PBPagerViewController
//
//  Created by Paolo Boschini on 06/04/15.
//  Copyright (c) 2015 Paolo Boschini. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let vc1 = ExampleViewController()
        vc1.view.backgroundColor = UIColor.redColor()
        let tuple1: (String, UIViewController) = (vc1.title!, vc1)

        var vc2 = ExampleViewController()
        vc2.view.backgroundColor = UIColor.greenColor()
        let tuple2: (String, UIViewController) = ("CustomTitle", vc2)
        
        var vc3 = ExampleViewController()
        vc3.view.backgroundColor = UIColor.yellowColor()
        let tuple3: (String, UIViewController) = ("Third VC", vc3)
        
        let pages: [(String, UIViewController)] = [tuple1, tuple2, tuple3]
        let pbPager = PBPagerViewController(pages: pages)
        let nc = UINavigationController(rootViewController: pbPager)
//        let nc = UINavigationController(rootViewController: PBPagerViewController(pages: pages, backgroundColor: UIColor.lightGrayColor(), titleColor: UIColor.darkGrayColor(), gradientLocations: [0.2, 0.3, 0.7, 0.8]))
        
        vc1.parent = pbPager
        vc2.parent = pbPager
        vc3.parent = pbPager

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}