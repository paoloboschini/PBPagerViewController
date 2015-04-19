//
//  ExampleViewController.swift
//  PBPagerViewController
//
//  Created by Paolo Boschini on 06/04/15.
//  Copyright (c) 2015 Paolo Boschini. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    @IBOutlet var l1: UILabel!
    @IBOutlet var l2: UILabel!
    @IBOutlet var l3: UILabel!
    @IBOutlet var l4: UILabel!
    
    @IBOutlet var s1: UISlider!
    @IBOutlet var s2: UISlider!
    @IBOutlet var s3: UISlider!
    @IBOutlet var s4: UISlider!
    
    var parent: PBPagerViewController!
    
    init() {
        super.init(nibName: "ExampleViewController", bundle: nil)
        title = "ViewControllerTitle"
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        l1.text = "\(s1.value)"
        l2.text = "\(s2.value)"
        l3.text = "\(s3.value)"
        l4.text = "\(s4.value)"
    }
    
    @IBAction func sliderChanged(slider: UISlider) {
        var label = self.view.viewWithTag(slider.tag + 1) as! UILabel
        label.text = "\(slider.value)"
        for page in parent.pages {
            let vc = page as! ExampleViewController
            vc.s1.value = s1.value
            vc.s2.value = s2.value
            vc.s3.value = s3.value
            vc.s4.value = s4.value
            vc.l1.text = l1.text
            vc.l2.text = l2.text
            vc.l3.text = l3.text
            vc.l4.text = l4.text
        }
        parent.hMaskLayer.locations = [s1.value, s2.value, s3.value, s4.value]
    }
}