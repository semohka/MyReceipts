//
//  ReceiptsModel.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import RealmSwift

class Receipt: Object {
    @objc dynamic var product : String? = ""
    @objc dynamic var shop : String? = ""
    @objc dynamic var price : Int = 0
    @objc dynamic var myShops : String? = ""
    @objc dynamic var count : Int = 0
//    var imageData : String? = ""


    
    
    
    

static let myShops = [
"ВкусВилл","Дикси","Пятерочка","Лента","Карусель","Ларек"
]
    
    static func getReceipts() -> [Receipt] {
        let realm = try! Realm()
        let receipts = realm.objects(Receipt.self)
        return Array (receipts)
    }
}
