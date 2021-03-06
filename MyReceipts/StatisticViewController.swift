//
//  StatisticViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 20.08.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class StatisticViewController: UITableViewController {

    
    @IBOutlet weak var amountMoneyOfMonthLabel: UILabel!
    @IBOutlet weak var balanceMoneyOfMonthLabel: UILabel!
    @IBOutlet weak var resultSum: UILabel!
    @IBOutlet weak var productSum: UILabel!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var finishTimeField: UITextField!
    
    @IBOutlet weak var selectedProductLabel: UILabel!
    
    @IBAction func navToDetailStatistic(_ sender: Any) {
        
    }
    
    let datePickerStart = UIDatePicker()
    let datePickerFinish = UIDatePicker()
    
    let statisticAllTable = UITableViewController()
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        tableView.tableFooterView = UIView() // убирает разлиновку до конца страницы
            datePickerStart.date = Calendar.current.date(byAdding: .month, value: -1, to: datePickerFinish.date)!
            datePickerFinish.date = Date()

            startTimeField.inputView = datePickerStart
            finishTimeField.inputView = datePickerFinish
            
            getDateFromPickerStart()
            getDateFromPickerFinish()
            
        

            datePickerStart.datePickerMode = .date
    //        let localeID = Locale.preferredLanguages.first //чтобы не писать эти 2 строчки и не изменять в настройках телефона язык, можно в разделе инфо изменить Localization native development region
    //        datePickerStart.locale = Locale(identifier: localeID!)
            
            datePickerFinish.datePickerMode = .date
    //        let localeID = Locale.preferredLanguages.first
    //        datePickerFinish.locale = Locale(identifier: localeID!)
            

            
            let toolbarStart = UIToolbar()
            let toolbarFinish = UIToolbar()//кнопка "готово". далее параметры кнопки
            toolbarStart.sizeToFit()
            toolbarFinish.sizeToFit()
            let doneBottonStart = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionStart))
            let doneBottonFinish = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneActionFinish))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //кнопка "готово" справа
            toolbarStart.setItems([flexSpace,doneBottonStart], animated: true)
            toolbarFinish.setItems([flexSpace,doneBottonFinish], animated: true)
            
            startTimeField.inputAccessoryView = toolbarStart
            finishTimeField.inputAccessoryView = toolbarFinish
            
        }

        
        @objc func doneActionStart() {
            getDateFromPickerStart() //вызыв функуции
            view.endEditing(true)//закрывам датеПикер после ввода даты
        }
        
         @objc func doneActionFinish() {
            getDateFromPickerFinish()
            view.endEditing(true)
        }
        
        func getDateFromPickerStart() {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            startTimeField.text = formatter.string(from: datePickerStart.date)
        }
        
        func getDateFromPickerFinish() {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            finishTimeField.text = formatter.string(from: datePickerFinish.date)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
           
            self.amountMoneyOfMonthLabel.text = UserDefaults.standard.string(forKey: "AmountOfMonth") ?? "Сумма на месяц не введена"
            self.balanceMoneyOfMonthLabel.text = UserDefaults.standard.string(forKey: "Tap")
            
            let resultSum: Int =  realm.objects(Receipt.self).sum(ofProperty: "price")
            self.resultSum.text = String(resultSum)
            
            let productSum: Int = realm.objects(Receipt.self).sum(ofProperty: "count")
            self.productSum.text = String(productSum)
        }
        
     
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "selectProduct" {

                let newVC = segue.destination as! UINavigationController
                let targetController = newVC.topViewController as? ProductTable
                targetController!.statistic = self
            }
            
            if segue.identifier == "navToDetailStatistic" {

                let newVC = segue.destination as! UINavigationController
                let targetController = newVC.topViewController as? DetailStatisticViewController
                targetController?.selectedProduct = self.selectedProductLabel.text!
                
                targetController?.startTime = Date.parse(startTimeField.text!, format: "dd.MM.yyyy")
                targetController?.finishTime = Date.parse(finishTimeField.text!, format: "dd.MM.yyyy")
            }
        }


}
