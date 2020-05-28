//
//  StatisticsViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.05.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var resultSum: UILabel!
    @IBOutlet weak var productSum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
