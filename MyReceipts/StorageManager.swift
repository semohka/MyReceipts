//
//  StorageManager.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 19.05.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ receipt : Receipt){
        try! realm.write {
            realm.add(receipt)
        }
    }
}
