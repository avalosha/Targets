//
//  ExampleViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import UIKit

class ExampleViewController: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }

}
