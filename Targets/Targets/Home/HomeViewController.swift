//
//  HomeViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }

}
