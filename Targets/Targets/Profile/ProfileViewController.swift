//
//  ProfileViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: ExtensionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
