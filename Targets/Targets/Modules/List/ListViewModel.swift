//
//  ListViewModel.swift
//  Targets
//
//  Created by Sferea-Lider on 17/10/23.
//

import Foundation

class ListViewModel {
    public var statusCode = Observable(CodeResponse.success)
    public var digimonResponse = Observable(DigimonResponse())
    
    private var page = 0
    
    public func getDigimons() {
        let params: [String: Any] = ["page": page]
        let res = API.makeURLRequest(end: .digimon, parameters: params)
        
        API.request(url: res) { [weak self] (data, code) in
            if code != .success {
                print("Error! Code: ",code.rawValue," Message: ",code.message)
                self?.statusCode.value = code
            }
            
            guard let response: DigimonResponse = data?.decodeData() else { return }
            dump(response)
            self?.page += 1
            self?.digimonResponse.value = response
        }
    }
}
