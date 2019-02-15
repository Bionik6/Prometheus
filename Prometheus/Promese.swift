//
//  Promese.swift
//  Prometheus
//
//  Created by Ibrahima Ciss on 2/15/19.
//  Copyright © 2019 Ibrahima Ciss. All rights reserved.
//

import Foundation

class Promise<T> {
    
    let value: T?
    
    init(value: T?) {
        self.value = value
    }

    func fullfill(_ value: T) {
        
    }
    
    func fail(_ error: Error) {
        
    }
}
