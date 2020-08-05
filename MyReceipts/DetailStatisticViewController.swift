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
        self.navigationItem.titleView = setTitle(title: selectedProduct, subtitle: "\(formatterTime(date: startTime)) - \(formatterTime(date: finishTime))")
        
        textColor(color: .white)
        
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))

        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.black
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }

        return titleView
    }
    
    
    
    func formatterTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
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
            let colorLeft = UIColor(red: 0.05, green: 0.48, blue: 0.70, alpha: 0.8)
            let colorRight = UIColor(red: 0.69, green: 0.39, blue: 0.50, alpha: 1.00)
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
