//
//  HomeModel.swift
//  Targets
//
//  Created by Sferea-Lider on 17/10/23.
//

import Foundation

// MARK: - DigimonResponse
struct DigimonResponse: Codable {
    var content: [Content]?
    var pageable: Pageable?
}

// MARK: - Content
struct Content: Codable {
    var id: Int?
    var name: String?
    var href: String?
    var image: String?
}

// MARK: - Pageable
struct Pageable: Codable {
    var currentPage, elementsOnPage, totalElements, totalPages: Int?
    var previousPage: String?
    var nextPage: String?
}
