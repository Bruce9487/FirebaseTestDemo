//
//  GroceryItem.swift
//  FirebaseTestDemo
//
//  Created by Bruce Chen on 2018/4/18.
//  Copyright © 2018年 bruce. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct GroceryItem {
    
    let key: String
    let name: String
    let addedByUser: String
    let ref: DatabaseReference?
    var completed: Bool
    let time: String
    
    init(name: String, addedByUser: String, completed: Bool, key: String = "", time: String) {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.time = time
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        addedByUser = snapshotValue["addedByUser"] as! String
        completed = snapshotValue["completed"] as! Bool
        time = snapshotValue["time"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "completed": completed,
            "time": time
        ]
    }
    
}
