//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

private enum Error {
    case lastElementIsSign, expressionIncomplete, expressionTooShort
}

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var expression: Expression!
  
    // View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = ""
        expression = Expression()
    }
    
    // View actions
    @IBAction private func numberButtonTapped(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        
        if expression.containsEqualsSign || textView.text.contains("Erreur") {
            reset()
        }
        
        textView.text += numberText
        expression.string += numberText
    }
    
    @IBAction private func signButtonTapped(_ sender: UIButton) {
        guard let sign = sender.title(for: .normal) else { return }

        guard !expression.elements.isEmpty, !textView.text.contains("Erreur") else { return }
        
        // if there's a result from a previous calculation, show it as first element
        if expression.containsEqualsSign {
            textView.text = expression.elements.last
            expression.string = expression.elements.last!
        }
        
        // if a sign can be added, add it; otherwise show related error message
        if expression.isCoherent {
            textView.text += " \(sign) "
            expression.string += " \(sign) "
        } else {
            showErrorMessage(.lastElementIsSign)
        }
    }
    
    @IBAction private func equalsButtonTapped(_ sender: UIButton) {
        if expression.containsEqualsSign { return }
        
        guard expression.isCoherent else {
            showErrorMessage(.expressionIncomplete)
            return
        }
        
        guard expression.hasEnoughElements else {
            showErrorMessage(.expressionTooShort)
            return
        }
        
        textView.text += " = \(expression.result)"
        expression.string += " = \(expression.result)"
    }
    
    @IBAction func cButtonTapped(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        guard expression.isCoherent else { return }

        textView.text += "."
        expression.string += "."
    }
    
    private func reset() {
        textView.text = ""
        expression.string = ""
    }
    
    private func showErrorMessage(_ error: Error) {
        var title: String
        var message: String
        
        switch error {
        case .lastElementIsSign:
            title = "Erreur !"
            message = "Il y a déjà un opérateur !"
        case .expressionIncomplete:
            title = "Expression incomplète !"
            message = "Veuillez compléter votre calcul."
        case .expressionTooShort:
            title = "Expression trop courte !"
            message = "Veuillez continuer votre calcul."
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
