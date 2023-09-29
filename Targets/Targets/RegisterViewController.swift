//
//  RegisterViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: ExtensionViewController {

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
    
    private func registerWithFirebase() {
        guard let email = emailTF.text, let password = passTF.text else {
            statusLbl.text = "FALTAN DATOS"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                if let _ = Auth.auth().currentUser {
                    self.statusLbl.text = "REGISTRADO"
                    self.openViewController()
                }
            }
            else {
                self.statusLbl.text = "ERROR AL LOGUEARSE: \(error.debugDescription)))"
                self.cleanMessages()
            }
        }
    }
    
    private func cleanMessages() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.statusLbl.text = ""
        }
    }
    
    private func openLoginVC() {
        self.navigationController?.popViewController(animated: true)
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as?  LoginViewController {
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }

    @IBAction func onClickRegisterBtn(_ sender: Any) {
        registerWithFirebase()
    }
    
    @IBAction func onClickLoginBtn(_ sender: Any) {
        openLoginVC()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    /// Recibe la entrada de texto
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case emailTF:
            print("Login Email: \(textField.text ?? "")")
        case passTF:
            print("Login Pass: \(textField.text ?? "")")
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
