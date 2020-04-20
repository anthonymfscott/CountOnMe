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
        
        if textView.containsEqualSign {
            reset()
        }
        
        textView.text += numberText
        expression.add(numberText)
    }
    
    @IBAction private func signButtonTapped(_ sender: UIButton) {
        guard let sign = sender.title(for: .normal) else { return }

        if textView.containsEqualSign {
            textView.text = expression.elements[0]
        }
        
        if expression.canAddOperator {
            textView.text += " \(sign) "
            expression.add(sign)
        } else {
            showErrorMessage(.lastElementIsSign)
        }
    }
    
    @IBAction private func equalButtonTapped(_ sender: UIButton) {
        if textView.containsEqualSign { return }
        
        guard expression.isCorrect else {
            showErrorMessage(.expressionIncomplete)
            return
        }
        
        guard expression.hasEnoughElements else {
            showErrorMessage(.expressionTooShort)
            return
        }
        
        textView.text.append(" = \(expression.result)")
    }
    
    private func reset() {
        textView.text = ""
        expression.reset()
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
            message = "Veuillez entrer une expression correcte."
        case .expressionTooShort:
            title = "Expression trop courte !"
            message = "Veuillez démarrer un nouveau calcul."
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension UITextView {
    var containsEqualSign: Bool {
        return self.text.firstIndex(of: "=") != nil
    }
}
