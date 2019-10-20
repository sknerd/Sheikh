//
//  StorageManager.swift
//  Sheikh
//
//  Created by renks on 17/10/2019.
//  Copyright © 2019 Renald Shchetinin. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ car: Car) {
        
        try! realm.write {
            realm.add(car)
        }
    }
    
    static func deleteObject(_ car: Car) {
        
        try! realm.write {
            realm.delete(car)
        }
    }
}

