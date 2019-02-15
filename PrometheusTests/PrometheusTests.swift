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
        let stringValue = "Hello World"
        
        let promise = Promise<String>()
        XCTAssertNil(promise.value)
        
        promise.fullfill(stringValue)
        XCTAssertNotNil(promise.value)
        
        if let value = promise.value {
            XCTAssertEqual(value, stringValue)
        }
    }
    
    
    func testFullfillCallsThenBlock() {
        let stringValue = "Hello World"
        
        let promise = Promise<String>()
        let exp = expectation(description: "did not call then block")
        _ = promise.then { value in
            exp.fulfill()
            XCTAssertEqual(value, stringValue)
        }
        promise.fullfill(stringValue)
        wait(for: [exp], timeout: 1.0)
    }
    

    func testFailCallsCatchBlock() {
        let promise = Promise<String>()
        let exp = expectation(description: "did not call catch block")
        let testError = NSError(domain: "test", code: 1, userInfo: nil)
        promise.then { value in
            XCTFail()
        }.catch { error in
            exp.fulfill()
            let e = error as NSError
            XCTAssertEqual(e.domain, "test")
            XCTAssertEqual(e.code, 1)
        }
        
        promise.fail(testError)
        wait(for: [exp], timeout: 1.0)
    }
    
    
    func testFailSetsError() {
        let promise = Promise<String>(value: nil)
        let testError = NSError(domain: "test", code: 1, userInfo: nil)
        promise.fail(testError)
        XCTAssertNotNil(promise.error)
        if let error = promise.error as NSError? {
            XCTAssertEqual(error, testError)
        }
    }
    
    
    func testMapTransformsFutureValue() {
        let promise = Promise<Int>()
        let exp = expectation(description: "did not call then block")
        promise.map { x in
            return String(x)
        }.then { value in
            exp.fulfill()
            XCTAssertEqual(value, "5")
        }.catch { _ in
            XCTFail()
        }
        promise.fullfill(5)
        wait(for: [exp], timeout: 1.0)
    }
    
    
    func testMapCarriesOverErrors() {
        let promise = Promise<Int>()
        let testError = NSError(domain: "test", code: 1, userInfo: nil)
        let exp = expectation(description: "did not call catch block")
        promise.map { x in
            return String(x)
        }.then { _ in
            XCTFail()
        }.catch { error in
            exp.fulfill()
            let e = error as NSError
            XCTAssertEqual(e.domain, "test")
            XCTAssertEqual(e.code, 1)
        }
        promise.fail(testError)
        wait(for: [exp], timeout: 1.0)
    }

    
}
