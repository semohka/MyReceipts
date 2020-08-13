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
    

    
    static func testReceipts (){
        let products = ["Молоко", "Сыр", "Компот", "Чай", "Колбаса", "Греча", "Рис", "Кефир"]
        let shops = ["ВкусВилл", "Пятерочка", "Дикси", "Лента", "Карусель"]


        
        for i in 0...200{
            let counts = Int.random(in: 1 ... 3)
            let price = Int.random(in: 50 ... 300)
            let finalPrice = counts * price
            let randomDate = Date.randomBetween(start: "2020-01-01", end: "2020-07-20", format: "yyyy-MM-dd")//сюда передаем параметры
            let randommDate = Date.parse(randomDate, format: "yyyy-MM-dd")
            let newReceipt = Receipt(value: ["product": products.randomElement()!, "shop": shops.randomElement()!, "price": finalPrice, "myShops": "ВкусВилл", "count": counts, "comment": "Комментарий \(i)", "date": randommDate, "primaryPrice": price])
            
            saveObject(newReceipt)
            

        }
        
    }
    static func deleteObject(_ receipt : Receipt){
        try! realm.write {
            realm.delete(receipt)
        }
    }
}

extension Date {
    
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String { //определяются параметры
        let date1 = Date.parse(start, format: format)
        let date2 = Date.parse(end, format: format)
        return Date.randomBetween(start: date1, end: date2).dateString(format)
    }

    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    func dateString(_ format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
}
