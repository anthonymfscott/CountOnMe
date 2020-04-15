//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    func testAddition() {
        let addition = SimpleCalc(operationsToReduce: ["2", "+", "3"])
        
        XCTAssertEqual(addition.result, "5")
    }
    
    func testSubstraction() {
        let substraction = SimpleCalc(operationsToReduce: ["2", "-", "3"])
        
        XCTAssertEqual(substraction.result, "-1")
    }
    
    func testMultiplication() {
        let multiplication = SimpleCalc(operationsToReduce: ["2", "x", "3"])
        
        XCTAssertEqual(multiplication.result, "6")
    }
}
