//
//  User.swift
//  FirebaseTestDemo
//
//  Created by Bruce Chen on 2018/4/18.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuthUI
import FirebaseAuth

struct User {
    
    let uid: String
    let email: String
    
    init(authData: Auth) {
        uid = (authData.currentUser?.uid)!
        email = (authData.currentUser?.email)!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
