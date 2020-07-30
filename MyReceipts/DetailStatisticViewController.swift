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
    
    
    
    var selectedProduct: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allPrice()
        title = selectedProduct
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    

    func allPrice() {
        let minPrice: Int? = realm.objects(Receipt.self)
            .filter("product == %@", selectedProduct)
            .min(ofProperty: "primaryPrice")
        self.minPriceLabel.text = String(minPrice ?? 0)
        
        let maxPrice: Int? = realm.objects(Receipt.self)
            .filter("product == %@", selectedProduct)
            .max(ofProperty: "primaryPrice")
        self.maxPriceLabel.text = String(maxPrice ?? 0)
        
        let midPrice: Double? = realm.objects(Receipt.self)
            .filter("product == %@", selectedProduct)
            .average(ofProperty: "primaryPrice")
        self.midPriceLabel.text = String(midPrice ?? 0)
    }
    
    

    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
    
    guard let newReceiptsVC = segue.source as? StatisticsViewController else { return }
        newReceiptsVC.navToDetailStatistic(self)
    }
}

