//
//  ViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 27/09/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
#if DEV
        print("This is a Development Environment")
#else
        print("This is a Production Environment")
#endif
    }


}

