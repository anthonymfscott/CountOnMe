//
//  Expression.swift
//  CountOnMe
//
//  Created by anthonymfscott on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo - © 2020 anthonymfscott. All rights reserved.
//

import Foundation

private enum Sign: String, CaseIterable {
    case multiplication = "x", division = "÷", addition = "+", subtraction = "-"

    static var allCasesRawValues: [String] {
        return Sign.allCases.map { $0.rawValue }
    }
}

class Expression {
    // MARK: Properties
    var input = ""

    var elements: [String] {
        return input.split(separator: " ").map { "\($0)" }
    }
    
    var isCoherent: Bool {
        // if the expression finishes with a sign, return false; return true otherwise
        for sign in Sign.allCasesRawValues where elements.last == sign {
            return false
        }
        return true
    }

    var hasEnoughElements: Bool {
        return elements.count >= 3
    }

    var containsEqualsSign: Bool {
        return input.contains("=")
    }
    
    var canAddPoint: Bool {
        return isCoherent && !elements.last!.contains(".")
    }

    var result: String {
        var operationsToReduce = elements

        while operationsToReduce.count > 1 {
            let signIndex = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "÷" }) ?? 1
            
            guard
                let left = Float(operationsToReduce[signIndex - 1]),
                let right = Float(operationsToReduce[signIndex + 1]),
                let sign = Sign(rawValue: operationsToReduce[signIndex])
                    else { return "Erreur d'opérateur" }

            let result: Float
            switch sign {
            case .addition:
                result = left + right
            case .subtraction:
                result = left - right
            case .multiplication:
                result = left * right
            case .division:
                guard right != 0 else { return "Erreur" }
                result = left / right
            }

            for _ in 1...3 {
                operationsToReduce.remove(at: signIndex - 1)
            }

            operationsToReduce.insert("\(result)", at: signIndex - 1)
        }

        let finalResult = simplify(operationsToReduce.first!)

        return finalResult
    }

    // MARK: Private methods
    private func simplify(_ floatNumber: String) -> String {
        let resultParts = floatNumber.split(separator: ".")
        if resultParts[1] != "0" {
            return floatNumber
        }
        return String(resultParts[0])
    }
}
