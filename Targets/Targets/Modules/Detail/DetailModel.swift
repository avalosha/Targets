//
//  DetailModel.swift
//  Targets
//
//  Created by Sferea-Lider on 13/02/24.
//

import Foundation

// MARK: - Item
struct Item: Codable {
    var id: Int?
    var name: String?
    var xAntibody: Bool?
    var images: [Image]?
    var levels: [Level]?
    var types: [TypeElement]?
    var attributes: [Attribute]?
}

// MARK: - Attribute
struct Attribute: Codable {
    var id: Int?
    var attribute: String?
}

// MARK: - Image
struct Image: Codable {
    var href: String?
    var transparent: Bool?
}

// MARK: - Level
struct Level: Codable {
    var id: Int?
    var level: String?
}

// MARK: - TypeElement
struct TypeElement: Codable {
    var id: Int?
    var type: String?
}
