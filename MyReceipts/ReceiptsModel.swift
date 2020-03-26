//
//  ReceiptsModel.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import Foundation

struct Receipt {
    var shop : String
    var price : String
    var image : String


static let myReceipts = [
"ВкусВилл","Дикси","Пятерочка","Лента","Карусель","Ларек"
]
    
    static func getPlaces() -> [Receipt] {
        var places = [Receipt]()
        for receipts in myReceipts {
            places.append(Receipt(shop: receipts, price: "2000руб.", image: receipts))        }
        return places
        
        
    }
    
    
}
