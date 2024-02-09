//
//  ExampleModel.swift
//  Targets
//
//  Created by Sferea-Lider on 07/02/24.
//

import Foundation

struct Fee: Equatable {
    
    var category: Category
    var amount: Double
    
    enum Category: Equatable {
        case enrollment
        case course(String)
    }
}

class TestConstants {
    static let someString = "String"
    static let someFeeCategory = Fee.Category.enrollment
    static let someDouble = 1.0
    static let someOtherDouble = 2.0
    static let someOtherFeeCategory = Fee.Category.course("String")
}

struct Invoice: Equatable {
    var fees = [Fee]()
    var totalPayableAmount: Double {
        fees.reduce(0) { runningTotal, fee in
            runningTotal + fee.amount
        }
    }
    
    mutating func addFee(_ fee:Fee) {
        fees.append(fee)
    }
}

struct Course: Equatable {
    var title: String
    var credits: Double
}
