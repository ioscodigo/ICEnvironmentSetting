//
//  ViewController.swift
//  ICEnvironmentSetting
//
//  Created by Fajar Agung W on 06/05/2017.
//  Copyright (c) 2017 Fajar Agung W. All rights reserved.
//

import UIKit
import ICEnvironmentSetting

class ViewController: UIViewController,ICEnvironmentSettingDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ICEnvironmentSetting.setupTouch(self.view)
        ICEnvironmentSetting.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadEnvironment(environment: ENVIRONMENT) {
        print(" ENV \(environment)".ENV )
    }

}

