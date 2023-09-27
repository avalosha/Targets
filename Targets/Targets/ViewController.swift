//
//  ViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 27/09/23.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var testBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
#if DEV
        print("*** This is a Development Environment ***")
        Analytics.logEvent("Development", parameters: nil)
        testBtn.setTitle("Development", for: .normal)
#else
        print("*** This is a Production Environment ***")
        Analytics.logEvent("Production", parameters: nil)
        testBtn.setTitle("Production", for: .normal)
#endif
    }

    @IBAction func onClickTestBtn(_ sender: Any) {
        print("Click btn")
        Analytics.logEvent("click_btn", parameters: nil)
    }
}

