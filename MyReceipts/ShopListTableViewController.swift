//
//  ShopListTableViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 02.09.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class ShopListTableViewController: UITableViewController {
    
    
    var shops = realm.objects(Shop.self)

    let cellReuseIdentifier = "cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shops.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell?

        let shop = shops[indexPath.row]

        cell?.textLabel?.text = shop.shopTitle
        

        return cell!
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//
//            animals.remove(at: indexPath.row)
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        } else if editingStyle == .insert {
//        }
//    }
    

}
    



