//
//  ExtensionViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit

class ExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func openViewController() {
        var storyBoard : UIStoryboard?
        var vc: UIViewController?
        
        storyBoard = UIStoryboard(name: "Main", bundle:nil)
        vc = storyBoard?.instantiateViewController(withIdentifier: "ViewController")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

extension ExtensionViewController {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    // MARK: - Keyboards
    func enableKeyBoardToggle(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardWillChangeLogic(isShow: true, keyboardHeight: keyboardSize.height)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardWillChangeLogic(isShow: false, keyboardHeight: 0)
    }
    
    @objc func keyboardWillChangeLogic(isShow:Bool, keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.view.frame.origin.y = -(isShow ? keyboardHeight : 0)
            self.view.layoutIfNeeded()
        }
    }
}
