//
//  Observable.swift
//  Targets
//
//  Created by Sferea-Lider on 17/10/23.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            listeners.forEach{$0(value)}
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private var listeners: [((T) -> Void)] = []
    
    func bind(_ listener:@escaping (T) -> Void) {
        self.listeners.append(listener)
    }
}
