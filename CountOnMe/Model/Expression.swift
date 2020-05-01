//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by anthonymfscott on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

// intérêt ?
enum Sign: String, CaseIterable {
    case addition = "+", substraction = "-", multiplication = "x", division = "÷"
    
    static var allCasesRawValues: [String] {
        return Sign.allCases.map { $0.rawValue }
    }
}

class Expression {
    var string = ""

    var elements: [String] {
        return string.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var isCoherent: Bool {
        for sign in Sign.allCasesRawValues where elements.last == sign {
            return false
        }
        return true
    }
    
    var hasEnoughElements: Bool {
        return elements.count >= 3
    }
    
    var containsEqualsSign: Bool {
        return string.firstIndex(of: "=") != nil
    }
    
    var result: String {
        var operationsToReduce = elements
        
        for signArray in ["x", "÷", "+", "-"] {
            
            while operationsToReduce.contains(signArray) {
        
                let signIndex = operationsToReduce.firstIndex(of: signArray)!
                
//                guard lets
                let left = Float(operationsToReduce[signIndex - 1])!
                let right = Float(operationsToReduce[signIndex + 1])!
                let sign = Sign(rawValue: signArray)!
                
                let result: Float
                switch sign {
                case .addition:
                    result = left + right
                case .substraction:
                    result = left - right
                case .multiplication:
                    result = left * right
                case .division:
                    guard right != 0 else { return "Erreur" }
                    result = left / right
//                default:
//                    return "Opérateur inconnu !"
                }
                
                for _ in 1...3 {
                    operationsToReduce.remove(at: signIndex - 1)
                }
                
                operationsToReduce.insert("\(result)", at: signIndex - 1)
                
            }
    }
        
        let finalResult = simplify(operationsToReduce.first!)
        // directement appeler simplify dans return ?
        return finalResult
    }
    
    private func simplify(_ floatNumber: String) -> String {
        let resultParts = floatNumber.split(separator: ".")
        if resultParts[1] != "0" {
            return floatNumber
        }
        return String(resultParts[0])
    }
}
