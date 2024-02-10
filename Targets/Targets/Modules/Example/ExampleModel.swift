//
//  ExampleModel.swift
//  Targets
//
//  Created by Sferea-Lider on 07/02/24.
//

import Foundation

protocol Identifiable {
    var id: String { get set}
    func identify()
}

extension Identifiable {
    func identify() {
        print("My ID is ",id)
    }
}

struct User: Identifiable {
    var id: String
}

// *****************************************

protocol Vehicle {
    var numberOfWheels: Int { get }
    func start()
    func stop()
}

extension Vehicle {
    func start() {
        print("Vehicle starting...")
    }
}

struct Car: Vehicle {
    var numberOfWheels: Int { return 4 }
    
    func start() {
        print("Car starting...")
    }
    
    func stop() {
        print("Car stopping...")
    }
    
}

struct MotorCycle: Vehicle {
    var numberOfWheels: Int
    
    func stop() {
        print("Motorcycle stopping...")
    }
    
}

// *****************************************

protocol Flying {
    func takeOff()
    func land()
}

protocol Swimming {
    func dive()
    func surface()
}

// Protocol Composition: AdvancedVehicle
typealias AdvancedVehicle = Vehicle & Flying & Swimming

struct Seaplane: AdvancedVehicle {
    
    // MARK: - Vehicle protocol
    var numberOfWheels: Int { return 4 }
    
    func start() {
        print("Seaplane starting...")
    }
    
    func stop() {
        print("Seaplane stopping...")
    }
    
    // MARK: - Flying protocol
    func takeOff() {
        print("Seaplane taking off...")
    }
    
    func land() {
        print("Seaplane landing...")
    }
    
    // MARK: - Swimming protocol
    func dive() {
        print("Seaplane diving...")
    }
    
    func surface() {
        print("Seaplane surfacing...")
    }
}
