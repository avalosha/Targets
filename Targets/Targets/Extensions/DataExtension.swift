//
//  DataExtension.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import Foundation

extension Data {
    func decodeData<T:Decodable>() -> T? {
        do {
            let response = try JSONDecoder().decode(T.self, from: self)
            return response
        } catch let jsonError {
            print("Falied to decode Json: ",jsonError)
            return nil
        }
    }
}
