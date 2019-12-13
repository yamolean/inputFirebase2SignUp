//
//  ViewController.swift
//  SignUpFirebase
//
//  Created by 矢守叡 on 2019/12/14.
//  Copyright © 2019 yamolean. All rights reserved.
//

import UIKit
import Firebase

final class ViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    fileprivate func showErrorIfNeeded(_ errorOrNil: Error?) {
        guard let error = errorOrNil else { return }
        let message = "エラーが起きました"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction fileprivate func didTapSignUpButton(_ sender: Any) {
    }
    
}

