//
//  NewReceiptViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 19.04.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class NewReceiptViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StorageManager.shops.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueSelected = StorageManager.shops[row] as String
        

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StorageManager.shops[row]
    }
    
    
    var currentReceipt: Receipt? //в преременной лежит объект класса Ресеипт, либо нил. Поэтому в единРесеипт мы проверяем на нил
    
    var newReceipt = Receipt() //объект класса Ресеипт (проинициализированный)
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var productField: UITextField!
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var shopPickerViewField: UIPickerView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var countErrorLabel: UILabel!
    @IBOutlet weak var priceErrorLabel: UILabel!
    @IBOutlet weak var primaryPrice: UITextField!
    
    
    var valueSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countErrorLabel.isHidden = true
        priceErrorLabel.isHidden = true
        tableView.tableFooterView = UIView() //убирает разлиновку до конца страницы
        
        
        saveButton.isEnabled = false
        productField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        countField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        shopPickerViewField.dataSource = self
        shopPickerViewField.delegate = self
        pickerView(shopPickerViewField, didSelectRow: 0, inComponent: 0) //первый магазин в списке пикервью идет по умолчанию
        priceField.addTarget(self, action: #selector(textFieldChanged), for: UIControl.Event.editingChanged)
        setupEditScreen()
        //для валидации: чтобы обработать данные в текстовом поле
    }
    
    
    func validateFields() {
        var isOk = true
        
        if countField.text == "" {
            isOk = false
        }
        if countField.text != "" && Int(countField.text!) ?? 0 == 0 {
            countErrorLabel.isHidden = false
            isOk = false
        }else{
            countErrorLabel.isHidden = true
        }
        
        if priceField.text == "" {
            isOk = false
        }
        if priceField.text != "" && Int(priceField.text!) ?? 0 == 0 {
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
        let newAmountMoney = Int(UserDefaults.standard.integer(forKey: "Tap")) - finalPrice
        UserDefaults.standard.set(newAmountMoney, forKey: "Tap")
        
        newReceipt = Receipt(value: ["product": productField.text!, "shop": valueSelected, "price": finalPrice, "count": Int(countField.text!) ?? 0, "comment": commentField.text!, "primaryPrice": Int(priceField.text!)!]) // заполнение объекта чека
        
        editReceipt() //нужно вызывать после создания нового чека, иначе продтягивается пустой объект классе есеипт
        if currentReceipt == nil {
            StorageManager.saveObject(newReceipt) //название класса у которого вызывается статическая функция
        }
        
    }
    
    
    func editReceipt() {
        if currentReceipt != nil { //редактируемый чек существует (объект)
            try! realm.write { //происходит перезапись в базу данных. Обновление текущего чека по объекту ниже (экземпляр класса Ресеипт)
                currentReceipt?.product = newReceipt.product //экземпляр класса с его свойствами которому присваиваем новое значение
                currentReceipt?.count = newReceipt.count
                currentReceipt?.shop = newReceipt.shop
                currentReceipt?.price = newReceipt.price
                currentReceipt?.comment = newReceipt.comment
            
            }
        }
    }
    
    private func setupEditScreen() { 
        if currentReceipt != nil { //объект редактирования чека не нил, инициализируем текстовые поля
            setupNavigationBar()
            productField.text = currentReceipt?.product
            countField.text = String(currentReceipt!.count)
//            shopField.text = currentReceipt?.shop
            if currentReceipt!.count != 0 {
              priceField.text = String(currentReceipt!.price/currentReceipt!.count)
            }
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

