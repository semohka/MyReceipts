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
    
    
    var isBackgroundAdded = false
    
    
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var midPriceLabel: UILabel!
    
    
    @IBOutlet weak var minLable: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    
    @IBOutlet weak var stackViewMin: UIStackView!
    @IBOutlet weak var stackViewMid: UIStackView!
    @IBOutlet weak var stackViewMax: UIStackView!
    
    
    var selectedProduct: String = ""
    var startTime: Date = Date()
    var finishTime: Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allPrice()
        title = selectedProduct
        textColor(color: .white)
    }
    
    
    
    func textColor(color: UIColor) {
        minPriceLabel.textColor = color
        midPriceLabel.textColor = color
        maxPriceLabel.textColor = color
        minLable.textColor = color
        midLabel.textColor = color
        maxLabel.textColor = color
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isBackgroundAdded {
            let colorLeft = UIColor(red: 0.25, green: 0.37, blue: 0.98, alpha: 0.8)
            let colorRight = UIColor(red: 0.99, green: 0.27, blue: 0.42, alpha: 0.8)
            print("layout")
            stackViewMin.addBackground(colorLeft)
            stackViewMid.addBackgroundGradiant(color1: colorLeft, color2: colorRight)
            stackViewMax.addBackground(colorRight)
            isBackgroundAdded = true
        }
        
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


extension UIStackView {
    func addBackground(_ color: UIColor, cornerRadius: CGFloat = 10) {
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = color
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(backgroundView, at: 0)
        backgroundView.layer.cornerRadius = cornerRadius
        addShadow(for: backgroundView)
    }
    
    func addBackgroundGradiant(color1: UIColor, color2: UIColor, cornerRadius: CGFloat = 10) {
        let backgroundView = UIView(frame: bounds)
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin]
        backgroundView.layer.cornerRadius = cornerRadius
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundView.bounds
        gradientLayer.colors  = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1,y: 0)
        gradientLayer.cornerRadius = cornerRadius
        backgroundView.layer.addSublayer(gradientLayer)
        addShadow(for: backgroundView)
        insertSubview(backgroundView, at: 0)
    }
    
    func addShadow(for view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 3
    }
}








final class GradientView: UIView {
    
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    // MARK: - properties
    
    var colors: [UIColor] = [] {
        didSet { gradientLayer.colors = colors.map { $0.cgColor } }
    }
    
    var startPoint: CGPoint {
        get { return gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }
    
    var endPoint: CGPoint {
        get { return gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }
    
    var locations: [Float] {
        get { return gradientLayer.locations?.map { $0.floatValue } ?? [] }
        set { gradientLayer.locations = newValue.map(NSNumber.init) }
    }
    
    // MARK: - getters
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
