//
//  ViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 27/09/23.
//

import UIKit
import Firebase
import Combine

class ViewController: ExtensionViewController {
    
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
        
    }
    
}

extension ViewController {
    private func useCombine() {
        // Crea un nombre de notificación personalizado
        let customNotification = Notification.Name("CustomButtonTap")
        // Crea un editor que emite un valor cuando se publica la notificación personalizada
        let buttonTapPublisher = NotificationCenter.default.publisher(for: customNotification)
        // Crea un suscriptor usando el operador receptor
        _ = buttonTapPublisher.sink { _ in
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
        _ = squaredNumbersPublisher.sink { squaredNumber in
            print("Squared: \(squaredNumber)")
        }
    }
    
    private func useCombineWithRealData() {
//        let url = URL(fileURLWithPath: "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0")
    }
}
