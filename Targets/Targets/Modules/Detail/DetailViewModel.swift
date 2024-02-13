//
//  DetailViewModel.swift
//  Targets
//
//  Created by Sferea-Lider on 13/02/24.
//

import Foundation

class DetailViewModel {
    public var statusCode = Observable(CodeResponse.success)
    public var item = Observable(Item())
    
    public func getItem(with id: Int) {
        let res = API.makeURLRequest(end: .item(id: id))
        
        API.request(url: res) { [weak self] (data, code) in
            if code != .success {
                print("Error! Code: ",code.rawValue," Message: ",code.message)
                self?.statusCode.value = code
            }
            
            guard let response: Item = data?.decodeData() else { return }
            dump(response)
            self?.item.value = response
        }
    }
}
