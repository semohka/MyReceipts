//
//  ReceiptsModel.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

struct Receipt {
    var shop : String
    var price : String
    var myShops : String


static let myShops = [
"ВкусВилл","Дикси","Пятерочка","Лента","Карусель","Ларек"
]
    
    static func getReceipts() -> [Receipt] {
        var receipts = [Receipt]()
        for shop in myShops {
            receipts.append(Receipt(shop: shop, price: "2000руб.", myShops: shop))}
        return receipts
    }
    
    
}
