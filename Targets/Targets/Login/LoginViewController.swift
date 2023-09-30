//
//  LoginViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: ExtensionViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupKeyboard()
        setupTextFields()
    }
    
    private func setupKeyboard() {
        setupHideKeyboardOnTap()
//        enableKeyBoardToggle()
    }
    
    private func setupTextFields() {
        emailTF.delegate = self
        passTF.delegate = self
    }
    
    private func loginWithFirebase() {
        guard let email = emailTF.text, let password = passTF.text else {
            statusLbl.text = "FALTAN DATOS"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if error == nil {
                if let _ = Auth.auth().currentUser {
                    self?.statusLbl.text = "LOGUEADO"
                    self?.openViewController()
                }
            }
            else {
                self?.statusLbl.text = "ERROR AL LOGUEARSE: \(error.debugDescription)))"
                self?.cleanMessages()
            }
        }
    }
    
    private func cleanMessages() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.statusLbl.text = ""
        }
    }
    
    private func openRegisterVC() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onClickEnterBtn(_ sender: Any) {
        loginWithFirebase()
    }
    
    @IBAction func onClickRegisterBtn(_ sender: Any) {
        openRegisterVC()
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    /// Recibe la entrada de texto
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case emailTF:
            print("Email: \(textField.text ?? "")")
        case passTF:
            print("Pass: \(textField.text ?? "")")
        default:
            print("ERROR !!!")
        }
    }
    
    /// Devuelve estado del textField.
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
