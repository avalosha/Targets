//
//  ChartsModel.swift
//  Targets
//
//  Created by Sferea-Lider on 12/02/24.
//

import Foundation

struct MonthlySales: Identifiable {
    var id: UUID = .init()
    var date: Date
    var sales: Double
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
