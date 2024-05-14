//
//  ViewController.swift
//  Contest (Animation Lab)
//
//  Created by Derek Stengel on 4/19/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if let text = emailTextField.text, text.contains("@gmail.com") {
            performSegue(withIdentifier: "SegueOne", sender: self)
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.emailTextField.transform = CGAffineTransform(translationX: 35, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.emailTextField.transform = CGAffineTransform.identity
                })
            }
        }
    }
}
