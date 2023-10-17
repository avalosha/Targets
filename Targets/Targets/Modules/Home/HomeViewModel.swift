//
//  HomeViewModel.swift
//  Targets
//
//  Created by Sferea-Lider on 17/10/23.
//

import Foundation

class HomeViewModel {
    public var statusCode = Observable(CodeResponse.success)
    public var digimonResponse = Observable(DigimonResponse())
    
    public func getDigimons() {
        let params: [String: Any] = ["page": 1]
        let res = API.makeURLRequest(end: .digimon, parameters: params)
        
        API.request(url: res) { [weak self] (data, code) in
            if code != .success {
                print("Error! Code: ",code.rawValue," Message: ",code.message)
                self?.statusCode.value = code
            }
            
            guard let response: DigimonResponse = data?.decodeData() else { return }
            dump(response)
            self?.digimonResponse.value = response
        }
    }
}
