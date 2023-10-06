//
//  ProfileViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: ExtensionViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }

    private func closeSessionWithFirebase() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            openInitialViewController()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

    @IBAction func onClickCloseSessionBtn(_ sender: Any) {
        closeSessionWithFirebase()
    }

}
