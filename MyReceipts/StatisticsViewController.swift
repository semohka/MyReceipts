//
//  StatisticsViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.05.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    
    @IBOutlet weak var amountMoneyOfMonthLabel: UILabel!
    @IBOutlet weak var balanceMoneyOfMonthLabel: UILabel!
    @IBOutlet weak var resultSum: UILabel!
    @IBOutlet weak var productSum: UILabel!
    @IBOutlet weak var imageAmountMoney: UIImageView!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var finishTimeField: UITextField!
    
    @IBOutlet weak var statisticTableField: UITextField!
    
    let datePickerStart = UIDatePicker()
    let datePickerFinish = UIDatePicker()
    
    let statisticAllTable = UITableViewController()
    
    
    
    //необходимо сдеалть так, чтобы у каждого текстФиелд был свой пикер
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimeField.inputView = datePickerStart
        finishTimeField.inputView = datePickerFinish
        
//        statisticTableField.inputView = statisticAllTable
    
        
        datePickerStart.datePickerMode = .date
//        let localeID = Locale.preferredLanguages.first //чтобы не писать эти 2 строчки и не изменять в настройках телефона язык, можно в разделе инфо изменить Localization native development region
//        datePickerStart.locale = Locale(identifier: localeID!)
        
        datePickerFinish.datePickerMode = .date
//        let localeID = Locale.preferredLanguages.first
//        datePickerFinish.locale = Locale(identifier: localeID!)
        
//        statisticAllTable.tableView =
        
        let toolbarStart = UIToolbar()
        let toolbarFinish = UIToolbar()//кнопка "готово" далее параметры кнопки
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
    
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
