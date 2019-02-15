//
//  Promese.swift
//  Prometheus
//
//  Created by Ibrahima Ciss on 2/15/19.
//  Copyright © 2019 Ibrahima Ciss. All rights reserved.
//

import Foundation

class Promise<T> {
    
    var value: T?
    private var thenCallbacks: [(T)->()] = []
    private var catchCallbacks: [(Error)->()] = []
    
    init(value: T?) {
        self.value = value
    }

    func fullfill(_ value: T) {
        self.value = value
        thenCallbacks.forEach { $0(value) }
    }
    
    func `catch`(_ callback: @escaping (Error)->()) -> Promise<T> {
        catchCallbacks.append(callback)
        return self
    }
    
    func then(_ callback: @escaping (T?)->()) -> Promise<T> {
        thenCallbacks.append(callback)
        return self
    }
    
    func fail(_ error: Error) {
        catchCallbacks.forEach { $0(error) }
    }
    
}
