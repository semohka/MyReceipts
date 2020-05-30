//
//  NewReceiptViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 19.04.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class NewReceiptViewController: UITableViewController {
    
    var currentReceipt: Receipt?
    
    var newReceipt = Receipt()

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var productField: UITextField!
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var shopField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var countErrorLabel: UILabel!
    @IBOutlet weak var priceErrorLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countErrorLabel.isHidden = true
        priceErrorLabel.isHidden = true
        tableView.tableFooterView = UIView() //убирает разлиновку до конца страницы
        
        
        saveButton.isEnabled = false
        productField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        countField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        shopField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        priceField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        setupEditScreen()
    }
    
//                // MARK: Table view delegate
//                    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                            view.endEditing(true)
//                    }
    
    func validateFields() {
        var isOk = true
        
        if countField.text == "" {
            isOk = false
        }
        if countField.text != "" && Int(countField.text!)! == 0 {
            countErrorLabel.isHidden = false
            isOk = false
        }else{
            countErrorLabel.isHidden = true
        }
        
        if priceField.text == "" {
            isOk = false
        }
        if priceField.text != "" && Int(priceField.text!)! == 0 {
            priceErrorLabel.isHidden = false
            isOk = false
        }else{
           priceErrorLabel.isHidden = true
        }
        
        if productField.text?.isEmpty == true {
            isOk = false
        }
        
        
        saveButton.isEnabled = isOk
    }
    
    
    func saveReceipt() {
        let finalPrice = Int(countField.text!)! * Int(priceField.text!)!
        newReceipt = Receipt(value: ["product": productField.text!, "shop": shopField.text!, "price": finalPrice, "myShops": shopField.text!, "count": Int(countField.text!) ?? 0, "comment": commentField.text!])
        
        if currentReceipt != nil {
            try! realm.write {
                currentReceipt?.product = newReceipt.product
                currentReceipt?.count = newReceipt.count
                currentReceipt?.shop = newReceipt.shop
                currentReceipt?.price = newReceipt.price
                currentReceipt?.comment = newReceipt.comment
            
            }
        } else {
            StorageManager.saveObject(newReceipt)
        }
        
    }
        
       
    private func setupEditScreen() {
        if currentReceipt != nil {
            setupNavigationBar()
            productField.text = currentReceipt?.product
            countField.text = String(currentReceipt!.count)
            shopField.text = currentReceipt?.shop
            priceField.text = String(currentReceipt!.price)
            commentField.text = currentReceipt?.comment
            
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentReceipt?.shop
        saveButton.isEnabled = true
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
        validateFields()
    }
}

