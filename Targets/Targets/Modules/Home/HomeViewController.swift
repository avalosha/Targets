//
//  HomeViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 29/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDigimons()
    }

    public func getDigimons() {
        let params: [String: Any] = ["page": 1]
        let res = API.makeURLRequest(end: .digimon, parameters: params)
        
        API.request(url: res) { [weak self] (data, code) in
            if code != .success {
                print("Code: ",code.rawValue," Message: ",code.message)
                self?.view.backgroundColor = .red
            }
            
            guard let response: DigimonResponse = data?.decodeData() else { return }
            dump(response)
            self?.view.backgroundColor = .green
        }
    }
}

// MARK: - DigimonResponse
struct DigimonResponse: Codable {
    let content: [Content]
    let pageable: Pageable
}

// MARK: - Content
struct Content: Codable {
    let id: Int
    let name: String
    let href: String
    let image: String
}

// MARK: - Pageable
struct Pageable: Codable {
    let currentPage, elementsOnPage, totalElements, totalPages: Int
    let previousPage: String
    let nextPage: String
}
