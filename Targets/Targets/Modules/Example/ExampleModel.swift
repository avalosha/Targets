//
//  ExampleModel.swift
//  Targets
//
//  Created by Sferea-Lider on 07/02/24.
//

import Foundation

// El enfoque de programación orientada a protocolos fomenta el cambio de mentalidad, pasando de pensar en términos de clases y herencia a pensar en comportamiento y composición.

protocol Identifiablee {
    var id: String { get set }
    func identify()
}

extension Identifiablee {
    func identify() {
        print("My ID is ",id)
    }
}

struct User: Identifiablee {
    var id: String
}

// *****************************************
// Protocolo

protocol Vehicle {
    var numberOfWheels: Int { get }
    func start()
    func stop()
}

// Extensión de protocolo 
// para implementaciones predeterminadas

extension Vehicle {
    func start() {
        print("Vehicle starting...")
    }
}

// Ejemplos:

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
// Composición de protocolos
// para dividir protocolos grandes en pequeños

protocol Flying {
    func takeOff()
    func land()
}

protocol Swimming {
    func dive()
    func surface()
}

typealias AdvancedVehicle = Vehicle & Flying & Swimming

struct Seaplane: AdvancedVehicle {
    
    // Vehicle protocol
    var numberOfWheels: Int { return 4 }
    
    func start() {
        print("Seaplane starting...")
    }
    
    func stop() {
        print("Seaplane stopping...")
    }
    
    // Flying protocol
    func takeOff() {
        print("Seaplane taking off...")
    }
    
    func land() {
        print("Seaplane landing...")
    }
    
    // Swimming protocol
    func dive() {
        print("Seaplane diving...")
    }
    
    func surface() {
        print("Seaplane surfacing...")
    }
}

// *****************************************
// Herencia de protocolo
// para agregar requisitos adicionales y especialización del comportamiento

protocol ElectricVehicle: Vehicle {
    var batteryLevel: Double { get }
    func recharge()
}

struct ElectricCar: ElectricVehicle {
    var numberOfWheels: Int { return 4}
    var batteryLevel: Double = 100.0
    
    func start() {
        print("Electric car starting...")
    }
    
    func stop() {
        print("Electric car stopping...")
    }
    
    func recharge() {
        print("Electric car recharging...")
    }
    
}

// *****************************************
// Genericos y Protocolos

protocol Stackable<T> {
    associatedtype T
    mutating func push(_ item: T)
    mutating func pop() -> T?
    mutating func count()
}

struct Stack<T>: Stackable {
    private var items = [T]()
    
    mutating func push(_ item: T) {
        print("pushed item: \(item)")
        items.append(item)
    }
    
    mutating func pop() -> T? {
        let item = items.popLast()
        print("popped item: \(String(describing: item))")
        return item
    }
    
    mutating func count() {
        for item in items {
            print("Item: ",item)
        }
        print("Total: ",items.count)
    }
}
