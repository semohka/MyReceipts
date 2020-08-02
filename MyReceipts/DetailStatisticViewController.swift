//
//  DetailStatisticViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 29.07.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit
import RealmSwift

class DetailStatisticViewController: UITableViewController {

    
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var midPriceLabel: UILabel!
    
    @IBOutlet weak var stackViewPrice: UIView!
    @IBOutlet weak var stackViewAll: UIStackView!
    
    
    
    var selectedProduct: String = ""
    var startTime: Date = Date()
    var finishTime: Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allPrice()
        title = selectedProduct
        
        
//        let stackViewGradient = CAGradientLayer()
//        let colorLeft = UIColor(red: 0.25, green: 0.37, blue: 0.98, alpha: 0.8)
//        let colorRight = UIColor(red: 0.99, green: 0.27, blue: 0.42, alpha: 0.8)
//        stackViewGradient.colors  = [colorLeft.cgColor, colorRight.cgColor]
//        stackViewGradient.frame = stackViewAll.frame
//        stackViewGradient.startPoint = CGPoint(x: 0,y: 0)
//        stackViewGradient.endPoint = CGPoint(x: 1,y: 0)
//        stackViewAll.layer.insertSublayer(stackViewGradient, at: 0)
////        UIColor(red: 0.85, green: 0.36, blue: 0.36, alpha: 1.00)
//        UIColor(red: 0.65, green: 0.91, blue: 0.93, alpha: 1.00)
//        UIColor(red: 0.15, green: 0.87, blue: 1.00, alpha: 1.00)
//        UIColor(red: 0.15, green: 0.34, blue: 0.89, alpha: 1.00)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func allPrice() {
        let minPrice: Int? = realm.objects(Receipt.self)
            .filter("product == %@", selectedProduct)
            .filter("date BETWEEN %@", [startTime, finishTime])
            .min(ofProperty: "primaryPrice")
        self.minPriceLabel.text = String(minPrice ?? 0)
        
        let maxPrice: Int? = realm.objects(Receipt.self)
            .filter("product == %@", selectedProduct)
            .filter("date BETWEEN %@", [startTime, finishTime])
            .max(ofProperty: "primaryPrice")
        self.maxPriceLabel.text = String(maxPrice ?? 0)
        
        let midPrice: Double? = realm.objects(Receipt.self)
            .filter("product == %@", selectedProduct)
            .filter("date BETWEEN %@", [startTime, finishTime])
            .average(ofProperty: "primaryPrice")
        if midPrice == nil {
            midPriceLabel.text = "Error"
        }else{
           self.midPriceLabel.text = String(midPrice!.rounded())
        }
        
    }
    
    

    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
    
    guard let newReceiptsVC = segue.source as? StatisticsViewController else { return }
        newReceiptsVC.navToDetailStatistic(self)
    }
}

