//
//  MainViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    
    var receipts = Receipt.getReceipts()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // вернет количество строк в зависимости от количества наших чеков
        
        return receipts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        // конфигурация ячейки. Является обязательным иначе программа упадет
        
        let receipt = receipts[indexPath.row]
        
        cell.shopLabel.text = receipt.shop
        cell.priceLabel.text = receipt.price
        
        if receipt.shop == nil {
             cell.imageOfStore.image = UIImage(named: receipt.myShops)
        } else {
            cell.imageOfStore.image = UIImage(named: receipt.shop)
        }
        
       
        
        cell.imageOfStore.layer.cornerRadius = cell.imageOfStore.frame.size.height / 2
        cell.imageOfStore.clipsToBounds = true
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newReceiptsVC = segue.source as? NewReceiptViewController else { return }
        
        newReceiptsVC.saveNewReceipt()
        receipts.append(newReceiptsVC.newReceipt!)
        tableView.reloadData()
    }
}
