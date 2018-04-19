//
//  LoginViewController.swift
//  FirebaseTestDemo
//
//  Created by Bruce Chen on 2018/4/18.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class LoginViewController: UIViewController, NVActivityIndicatorViewable {
    
    //畫面
    @IBOutlet weak var emailTextField: UITextField! //信箱輸入框
    @IBOutlet weak var passwordTextField: UITextField! //密碼輸入框
    
    //變數物件
    let indicatorSize = CGSize(width: 30, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: 按鈕相關事件
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        guard emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false else {
            let alert = showAlert(title: "提醒", message: "欄位不得為空")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        firebaseSignIn(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "註冊會員", message: "", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "請輸入電子信箱"
        }
        alertController.addTextField { (textfield) in
            textfield.placeholder = "請輸入密碼"
        }
        
        let okAction = UIAlertAction(title: "註冊", style: .default) { (alert) in
            
            let emailTextfield = alertController.textFields![0]
            let passTextfield = alertController.textFields![1]
            
            guard emailTextfield.text?.isEmpty == false  && passTextfield.text?.isEmpty == false else {
                let alert = showAlert(title: "提醒", message: "欄位不得為空")
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.firebaseRegister(email: emailTextfield.text, password: passTextfield.text)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Firebase相關事件
    
    func firebaseRegister(email: String?, password: String?) {
        
        guard email != nil && password != nil else { return }
        
        startAnimating(indicatorSize, message: "登入中請稍候...", type: .ballPulse)

        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            
            guard error == nil else {
                
                let alert = showAlert(title: "提醒", message: (error?.localizedDescription)!)
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
                
                guard error == nil else {
                    
                    let alert = showAlert(title: "提醒", message: (error?.localizedDescription)!)
                    
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                }
                
                self.performSegue(withIdentifier: "toListView", sender: self)
            })
        }
    }
    
    func firebaseSignIn(email: String?, password: String?) {
        
        startAnimating(indicatorSize, message: "登入中請稍候...", type: .ballPulse)
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
            
            guard error == nil else {
                
                let alert = showAlert(title: "提醒", message: (error?.localizedDescription)!)
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.stopAnimating()
            }
            
            self.performSegue(withIdentifier: "toListView", sender: self)
        })
    }
    
}
