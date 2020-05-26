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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let resultSum: Int =  realm.objects(Receipt.self).sum(ofProperty: "price")
//        self.resultSum.text = String(resultSum)
     print("viewDL")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let resultSum: Int =  realm.objects(Receipt.self).sum(ofProperty: "price")
        self.resultSum.text = String(resultSum)
        print("viewD")
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
