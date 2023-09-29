//
//  ViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 27/09/23.
//

import UIKit
import Firebase
import Combine
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var registrationEmailTF: UITextField!
    @IBOutlet weak var registrationPassTF: UITextField!
    @IBOutlet weak var registrationStatusLbl: UILabel!
    
    @IBOutlet weak var loginEmailTF: UITextField!
    @IBOutlet weak var loginPassTF: UITextField!
    @IBOutlet weak var loginStatusLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if DEV
        print("*** This is a Development Environment ***")
//        Analytics.logEvent("Development", parameters: nil)
#else
        print("*** This is a Production Environment ***")
//        Analytics.logEvent("Production", parameters: nil)
#endif
        
//        useCombine()
//        useCombineWithOperators()
//        useCombineWithRealData()
        
        setupKeyboard()
        setupTextFields()
    }
    
    private func setupKeyboard() {
        setupHideKeyboardOnTap()
//        enableKeyBoardToggle()
    }
    
    private func setupTextFields() {
        registrationEmailTF.delegate = self
        registrationPassTF.delegate = self
        loginEmailTF.delegate = self
        loginPassTF.delegate = self
    }

    @IBAction func onClickRegisterBtn(_ sender: Any) {
        guard let email = registrationEmailTF.text, let password = registrationPassTF.text else {
            registrationStatusLbl.text = "FALTAN DATOS"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                if let user = Auth.auth().currentUser {
                    self.registrationStatusLbl.text = "REGISTRADO"
                }
            }
            else {
                self.registrationStatusLbl.text = "ERROR AL REGISTRAR"
            }
        }
    }
    
    @IBAction func onClickLoginBtn(_ sender: Any) {
        guard let email = loginEmailTF.text, let password = loginEmailTF.text else {
            loginStatusLbl.text = "FALTAN DATOS"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil {
                if let user = Auth.auth().currentUser {
                    self?.loginStatusLbl.text = "LOGUEADO"
                    self?.openVCTwo()
                }
            }
            else {
                self?.loginStatusLbl.text = "ERROR AL LOGUEARSE"
            }
        }
    }
    
    /// Método para abrir la vista de NuevaInvitacionDos.
    private func openVCTwo() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCTwoID") as?  ViewControllerTwoViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    /// Recibe la entrada de texto
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case registrationEmailTF:
            print("Registro Email: \(textField.text ?? "")")
        case registrationPassTF:
            print("Registro Pass: \(textField.text ?? "")")
        case loginEmailTF:
            print("Login Email: \(textField.text ?? "")")
        case loginPassTF:
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

extension ViewController {
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

extension ViewController {
    private func useCombine() {
        // Crea un nombre de notificación personalizado
        let customNotification = Notification.Name("CustomButtonTap")
        // Crea un editor que emite un valor cuando se publica la notificación personalizada
        let buttonTapPublisher = NotificationCenter.default.publisher(for: customNotification)
        // Crea un suscriptor usando el operador receptor
        let buttonTapSuscriber = buttonTapPublisher.sink { _ in
            print("Boton presionado!")
        }
        // Emule un evento de pulsación de botón publicando la notificación personalizada
        NotificationCenter.default.post(name: customNotification, object: nil)
    }
    
    private func useCombineWithOperators() {
        // Crea un editor simple que emite números del 1 al 5
        let numbersPublisher = (1...5).publisher
        // Usar Map para elevar al cuadrado cada numero
        let squaredNumbersPublisher = numbersPublisher.map { number in
            return number * number
        }
        // Crea un suscriptor para recibir e imprimer los numeros elevados al cuadrado
        let subscriber = squaredNumbersPublisher.sink { squaredNumber in
            print("Squared: \(squaredNumber)")
        }
    }
    
    private func useCombineWithRealData() {
        let url = URL(fileURLWithPath: "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0")

    }
}
