//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by anthonymfscott on 15/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

// intérêt ?
enum Sign: String {
    case addition = "+", substraction = "-", multiplication = "x", division = "÷"
}

class Expression {
    var string = ""

    var elements: [String] {
        return string.split(separator: " ").map { "\($0)" }
    }
    
    private static let possibleSigns = ["+", "-", "x", "÷"]
    
    // Error check computed variables
    var isCoherent: Bool {
        for sign in Expression.possibleSigns where elements.last == sign {
            return false
        }
        return true
    }
    
    var hasEnoughElements: Bool {
        return elements.count >= 3
    }
    
    // déplacer dans Contrôleur ? (logique d'interface)
    var containsEqualsSign: Bool {
        return string.firstIndex(of: "=") != nil
    }
    
    // pas trop de logique pour une propriété calculée ?
    var result: String {
        var operationsToReduce = elements
        
        for sign in ["x", "÷", "+", "-"] {
            while operationsToReduce.contains(sign) {
                let signIndex = operationsToReduce.firstIndex(of: sign)!
                
                let left = Float(operationsToReduce[signIndex - 1])!
                let sign = sign
                let right = Float(operationsToReduce[signIndex + 1])!
                
                let result: Float
                switch sign {
                case "+":
                    result = left + right
                case "-":
                    result = left - right
                case "x":
                    result = left * right
                case "÷":
                    guard right != 0 else { return "Erreur" }
                    result = left / right
                default:
                    return "Opérateur inconnu !"
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
