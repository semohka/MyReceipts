//
//  MainViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    
    let receipts = Receipt.getPlaces()
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
        
        cell.shopLabel.text = receipts[indexPath.row].shop
        cell.priceLabel.text = receipts[indexPath.row].price
        cell.imageOfStore.image = UIImage(named: receipts[indexPath.row].image)
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
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
}
