//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

private enum Error {
    case sign, incomplete, short
}

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var expression: Expression!
  
    // View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expression = Expression()
    }
    
    // View actions
    @IBAction private func numberButtonTapped(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if textView.text.firstIndex(of: "=") != nil {
            textView.text = ""
            expression.reset()
        }
        
        textView.text.append(numberText)
        
        if expression.elements.count > 0 && Int(expression.elements[expression.elements.count - 1]) != nil {
            expression.elements[expression.elements.count - 1] += numberText
        } else {
            expression.elements.append(numberText)
        }
    }
    
    @IBAction private func signButtonTapped(_ sender: UIButton) {
        guard let sign = sender.title(for: .normal) else {
            return
        }
        
        if expression.canAddOperator {
            addSign(sign)
        } else {
            showErrorMessage(.sign)
        }
    }
    
    private func addSign(_ sign: String) {
        textView.text.append(" \(sign) ")
        expression.elements.append(sign)
    }
    
    @IBAction private func equalButtonTapped(_ sender: UIButton) {
        guard expression.isCorrect else {
            showErrorMessage(.incomplete)
            return
        }
        
        guard expression.hasEnoughElements else {
            showErrorMessage(.short)
            return
        }
        
        textView.text.append(" = \(expression.result)")
    }
    
    private func showErrorMessage(_ error: Error) {
        var title: String
        var message: String
        
        switch error {
        case .sign:
            title = "Erreur !"
            message = "Un opérateur est déjà mis !"
        case .incomplete:
            title = "Expression incomplète !"
            message = "Veuillez entrer une expression correcte."
        case .short:
            title = "Expression trop courte !"
            message = "Veuillez démarrer un nouveau calcul."
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func reset() {
        
    }
}
