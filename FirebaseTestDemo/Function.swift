//
//  Function.swift
//  FirebaseTestDemo
//
//  Created by Bruce Chen on 2018/4/19.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import UIKit

func showAlert(title: String, message: String) -> UIAlertController {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    return alert
}
