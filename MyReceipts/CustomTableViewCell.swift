//
//  CustomTableViewCell.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 25.03.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {


    @IBOutlet weak var imageOfStore: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var primaryPrice: UILabel!
    var myBG = "BGReceipt"
}
