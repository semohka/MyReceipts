//
//  ProductTableTest.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 24.07.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//


import UIKit
import RealmSwift

class ProductTableTest: UITableViewController{
    

    
    let statistic = StatisticsViewController()
    var products: Results<Receipt>! //массив в котором соджержится тип чеков
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        products = realm.objects(Receipt.self).distinct(by: ["product"])
        print(products.count)
//        self.productsLabel = products
        
        
//        statistic.statisticTableField =
 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.products[indexPath.row].product
          return cell
    }

}
