//
//  NewReceiptViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 19.04.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class NewReceiptViewController: UITableViewController {
    
    var newReceipt = Receipt()

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var shop: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var comment: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() //убирает разлиновку до конца страницы
        
        
        saveButton.isEnabled = false
        product.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
    }
    
//                // MARK: Table view delegate
//                    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                            view.endEditing(true)
//                    }
    
    func saveNewReceipt() {
        newReceipt = Receipt(value: ["product": product.text!, "shop": shop.text!, "price": Int(price.text!) ?? 0, "myShops": shop.text!, "count": Int(count.text!) ?? 0])
        StorageManager.saveObject(newReceipt)
       
        
    }
        
       
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
// MARK: Text field delegate

extension NewReceiptViewController: UITextFieldDelegate{
     // скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func textFieldChanged() {
        if product.text?.isEmpty == false {
            saveButton.isEnabled = true
        }else {
            saveButton.isEnabled = false
        }
    }
}

