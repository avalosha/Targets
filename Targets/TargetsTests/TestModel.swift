//
//  TestModel.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 09/02/24.
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
    static let someOtherString = "Another String"
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
    
    mutating func addFee(_ fee: Fee) {
        fees.append(fee)
    }
}

// Se añadio el hashable para poder usar el Set
struct Course: Equatable, Hashable {
    var title: String
    var credits: Double
}

// Se modifico para que no existan elementos duplicados
struct EnrolledStudent: Equatable {
//    var courses = [Course]()
    var courses = Set<Course>()
    
//    mutating func takeCourse(_ course: Course) {
////        courses.append(course)
//        courses.insert(course)
//    }
//
//    mutating func completeCourse(_ course: Course) {
//        courses.remove(course)
//    }
//
//    func generateInvoice() -> Invoice {
//        let enrollmentFee = Fee(category: .enrollment, amount: Configuration.enrollmentFeeAmount)
//        let courseFees = courses.map() { course in
//            Fee(category: .course(course.title), amount: course.credits * Configuration.enrolledSudentCourseCreditFeeAmount)
//        }
//        return ([enrollmentFee] + courseFees).reduce(into: Invoice()) { invoice, fee in
//            invoice.addFee(fee)
//        }
//
//    }
}

struct CasualStudent: Equatable {
    var courses = Set<Course>()

//    mutating func takeCourse(_ course: Course) {
//        courses.insert(course)
//    }
//
//    mutating func completeCourse(_ course: Course) {
//        courses.remove(course)
//    }
//
//    func generateInvoice() -> Invoice {
//        courses.map() { course in
//            Fee(category: .course(course.title), amount: course.credits * Configuration.casualStudentCourseCreditFeeAmount)
//        }.reduce(into: Invoice()) { invoice, fee in
//            invoice.addFee(fee)
//        }
//    }
}

extension EnrolledStudent: CourseTaking {}
extension CasualStudent: CourseTaking {}

protocol CourseTaking {
    var courses: Set<Course> { get set }
    mutating func takeCourse(_:Course)
    mutating func completeCourse(_: Course)
}

extension CourseTaking {
    mutating func takeCourse(_ course: Course) {
        courses.insert(course)
    }
    
    mutating func completeCourse(_ course: Course) {
        courses.remove(course)
    }
}

class Configuration {
    static var enrollmentFeeAmount = 200.0
    static var enrolledSudentCourseCreditFeeAmount = 50.0
    static var casualStudentCourseCreditFeeAmount = 75.0
}

protocol Invoicable {
    func generateInvoice() -> Invoice
}

protocol Enrolled {}

extension EnrolledStudent: Enrolled {}
extension EnrolledStudent: Invoicable {}

extension Invoicable where Self: Enrolled & CourseTaking {
    func generateInvoice() -> Invoice {
        let enrollmentFee = Fee(category: .enrollment, amount: Configuration.enrollmentFeeAmount)
        let courseFees = courses.map() { course in
            Fee(category: .course(course.title), amount: course.credits * Configuration.enrolledSudentCourseCreditFeeAmount)
        }
        return ([enrollmentFee] + courseFees).reduce(into: Invoice()) { invoice, fee in
            invoice.addFee(fee)
        }
    }
}

protocol Casual {}

extension CasualStudent: Casual {}
extension CasualStudent: Invoicable {}

extension Invoicable where Self: Casual & CourseTaking {
    func generateInvoice() -> Invoice {
        courses.map() { course in
            Fee(category: .course(course.title), amount: course.credits * Configuration.casualStudentCourseCreditFeeAmount)
        }.reduce(into: Invoice()) { invoice, fee in
            invoice.addFee(fee)
        }
    }
}
