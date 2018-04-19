//
//  DetailViewController.swift
//  FirebaseTestDemo
//
//  Created by Bruce Chen on 2018/4/18.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit
import FirebaseAuth

class DetailViewController: UIViewController {
    
    var string: String = ""
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = string
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: 按鈕相關事件
    
    @IBAction func signOutBtnClicked(_ sender: Any) {
        
        firebaseSignOut()
    }
    
    //MARK: Firebase相關事件
    
    func firebaseSignOut() {
        
        do {
            try Auth.auth().signOut()
            
            let vc: UIViewController! = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            let window = UIApplication.shared.windows[0]
            window.rootViewController = vc
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
