//
//  ViewController.swift
//  MixDevice
//
//  Created by Eric Lung on 2019/2/19.
//  Copyright © 2019 Mix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let device = MixDevice.shared
        device.add("xxxxxx", "dfdsfsd")
        device.add("yyyyyy", 12222)
        device.add("zzzz", ["cc": 33])
        print(device.jsonObject() ?? "")
    }
}

