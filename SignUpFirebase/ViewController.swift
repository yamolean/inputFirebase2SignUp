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
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let name = nameTextField.text ?? ""
        // 新しいユーザアカウント作成
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                // ユーザに表示用の名前を与える
                let req = user.createProfileChangeRequest()
                req.displayName = name
                req.commitChanges() { [weak self] error in
                    guard let self = self else { return }
                    if error == nil {
                        // emailを送るメソッド
                        user.sendEmailVerification() { [weak self] error in
                            guard let self = self else { return }
                            if error == nil {
                                // 仮登録完了画面へ遷移する処理
                            }
                            self.showErrorIfNeeded(error)
                        }
                    }
                    self.showErrorIfNeeded(error)
                }
            }
            self.showErrorIfNeeded(error)
        }
    }
    
    @IBAction func didTapSignInButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
         
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                // サインイン後の処理
                self.view.backgroundColor = .black
            }
            self.showErrorIfNeeded(error)
        }
    }
    
    @IBAction func passwordResetButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
         
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                // 送信完了後の処理
                //　なんでメールはくるけどここ呼ばれないの
                self.view.backgroundColor = .red
            }
            self.showErrorIfNeeded(error)
        }
    }
    
    @IBAction func didTapSignOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            showErrorIfNeeded(error)
        }
    }
    
    
}

