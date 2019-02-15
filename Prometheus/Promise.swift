//
//  Promese.swift
//  Prometheus
//
//  Created by Ibrahima Ciss on 2/15/19.
//  Copyright © 2019 Ibrahima Ciss. All rights reserved.
//

import Foundation

class Promise<T> {
    
    private(set) var value: T?
    private(set) var error: Error?
    
    private var thenCallbacks: [(T)->()] = []
    private var catchCallbacks: [(Error)->()] = []
    
    init(value: T? = nil) {
        self.value = value
    }

    func fullfill(_ value: T) {
        self.value = value
        thenCallbacks.forEach { $0(value) }
    }
    
    @discardableResult
    func `catch`(_ callback: @escaping (Error)->()) -> Promise<T> {
        catchCallbacks.append(callback)
        return self
    }
    
    func then(_ callback: @escaping (T)->()) -> Promise<T> {
        thenCallbacks.append(callback)
        return self
    }
    
    func fail(_ error: Error) {
        self.error = error
        catchCallbacks.forEach { $0(error) }
    }
    
    func map<S>(_ transformBlock: @escaping (T)->S) -> Promise<S> {
        let promise = Promise<S>()
        then { value in
            let transformedValue = transformBlock(value)
            promise.fullfill(transformedValue)
        }.catch { error in
            promise.fail(error)
        }
        return promise
    }
    
}
