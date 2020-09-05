//
//  SettingsViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 01.06.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit


class SettingsViewController: UITableViewController {
    
    
    
    @IBOutlet weak var amountMoneyTextField: UITextField!
    @IBOutlet weak var saveAmountMoney: UIButton!
    @IBOutlet weak var shopListLabel: UILabel!
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        showShopList()
        saveAmountMoney.isHidden = true
//        amountMoneyTextField.text = String(UserDefaults.standard.integer(forKey: "Tap"))
        tableView.tableFooterView = UIView()

        amountMoneyTextField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
//        UserDefaults.standard.set(amountMoneyTextField, forKey: "Tap")
        

    }
    
    func showShopList() {
//        shopListLabel.text! = ""
//        let shops = realm.objects(Receipt.self).distinct(by: ["shop"])
//        for shop in shops {
//            shopListLabel.lineBreakMode = .byWordWrapping
//            shopListLabel.numberOfLines = 0
//            shopListLabel.sizeToFit()
//            shopListLabel.text! += "\(shop.shop!)\r\n"
//
//        }
        
    }
    
//    func openAlert() {
//        let alert = UIAlertController(title: "Новый магазин", message: "", preferredStyle: UIAlertController.Style.alert)
//        let cancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil)
//        let ok = UIAlertAction(title: "Добавить", style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
//            let textField = alert.textFields?[0]
//
//
//            StorageManager.shops.append((textField?.text!)!)
//
//        }
//
//        alert.addAction(ok)
//        alert.addAction(cancel)
//        alert.addTextField { (textField: UITextField) in
//            textField.placeholder = "Введите новый магазин"
//        }
        
//        self.present(alert, animated: true, completion: nil)

//    }
    
    
    
    func validateFields() {
        if amountMoneyTextField.text != "" {
            saveAmountMoney.isHidden = false
        }
    }
    
    @objc func textFieldChanged() {
        validateFields()
    }

}
