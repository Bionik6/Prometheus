//
//  PrometheusTests.swift
//  PrometheusTests
//
//  Created by Ibrahima Ciss on 2/15/19.
//  Copyright © 2019 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import Prometheus

class PrometheusTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testInitializeWithValue() {
        let promise = Promise(value: 5)
        XCTAssertNotNil(promise.value)
        if let value = promise.value {
            XCTAssertEqual(value, 5)
        }
    }
 
    func testFullfillPromiseSetsValue() {
        let promise = Promise<String>(value: nil)
        XCTAssertNil(promise.value)
        
        promise.fullfill("Hello Guys")
        XCTAssertNotNil(promise.value)
        
        if let value = 
    }
}
