//
//  MainViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {

    
    
    var receipts: Results<Receipt>!
    
    var gradientColorForRow = UIColor(red: 0.05, green: 0.48, blue: 0.70, alpha: 0.8)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receipts = realm.objects(Receipt.self).sorted(byKeyPath: "date", ascending: false) // сортировка по дате, по убыванию
        
//        StorageManager.testReceipts()
        title = "Все покупки"
    }
    
    

  func gradient(frame:CGRect) -> CAGradientLayer {
      let layer = CAGradientLayer()
      layer.frame = frame
    layer.startPoint = CGPoint(x: 0,y: 0)
    layer.endPoint = CGPoint(x: 1,y: 1)
    let colorLeft = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.00)
    let colorRight = UIColor(red: 0.87, green: 0.86, blue: 0.86, alpha: 1.00)
    layer.colors = [colorLeft.cgColor,colorRight.cgColor]

      return layer
  }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // вернет количество строк в зависимости от количества наших чеков
        
        return receipts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
      
        cell.layer.insertSublayer(gradient(frame: cell.bounds), at:0)
        // конфигурация ячейки. Является обязательным иначе программа упадет
        
        let receipt = receipts[indexPath.row]
        
        
        
        cell.productLabel.text = receipt.product
        cell.countLabel.text = "\(receipt.count) шт."
        cell.priceLabel.text = String(receipt.price/receipt.count) + " руб. за ед."

        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        cell.dateLabel.text = dateFormatter.string(from: receipt.date)
        
        if receipt.shop == nil {
            cell.imageOfStore.image = UIImage(named: receipt.shop!)
        } else {
            cell.imageOfStore.image = UIImage(named: receipt.shop!)
        }
                
//        cell.imageOfStore.layer.cornerRadius = cell.imageOfStore.frame.size.height / 2
        cell.imageOfStore.clipsToBounds = true
        
        return cell
    }
    
    // MARK: - Table view delegate

//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let receipt = receipts[indexPath.row]
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
//            StorageManager.deleteObject(receipt)
//            self.receipts.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//
//        }
//        return [deleteAction]
//    }
    
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let receipt = receipts[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            
            
            //            0 извлечь из юзер дефолтс значение
            var extraction = UserDefaults.standard.integer(forKey: "Tap")
            //            1 к цене за месяц прибавить цену удаленного товара
            extraction += receipt.price
            //            2 обновить цену которая находится в юзер дефолтс
            UserDefaults.standard.set(extraction, forKey: "Tap")
            
            StorageManager.deleteObject(receipt)

            self.tableView.reloadData()
            self.title = String(extraction)

            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor(named: "myRed")
        
        
        
        
        
//        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, completionHandler in
//            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "NewReceiptViewController") as! NewReceiptViewController
//            redViewController.currentReceipt = receipt
//            redViewController.modalPresentationStyle = .fullScreen
//            self.present(redViewController, animated: true, completion: nil)
//
//            completionHandler(true)
//        }
//        editAction.backgroundColor = UIColor(named: "myGreen")
        
        
        
        
        
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    
    

    
//     MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let receipt = receipts[indexPath.row]
            let newReceiptVC = segue.destination as! NewReceiptViewController
            newReceiptVC.currentReceipt = receipt
            
        }
    }
    
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newReceiptsVC = segue.source as? NewReceiptViewController else { return }
        
        
        newReceiptsVC.saveReceipt()
        tableView.reloadData()

        
    }
 
}
