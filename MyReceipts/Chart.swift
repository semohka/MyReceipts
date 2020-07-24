//
//  Chart.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 14.07.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//
/*
import UIKit
import Charts
import TinyConstraints
import RealmSwift

class Chart: UIViewController, ChartViewDelegate {
    
    var receipts: Results<Receipt>!
    
    @IBOutlet weak var barView: UIView!
    
    lazy var lineChartView: LineChartView = {
        var chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        dateFormatter.timeZone = TimeZone(identifier: "UTC+3")
        dateFormatter.locale = NSLocale.current
        let xValuesNumberFormatter = ChartXAxisFormatter()
        xValuesNumberFormatter.dateFormatter = dateFormatter
        chartView.xAxis.valueFormatter = xValuesNumberFormatter
        
        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        receipts = realm.objects(Receipt.self)
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        setData()
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    
    func setData() {
        var yValues: [ChartDataEntry] = []
        

        for receipt in receipts {
            yValues.append(
                ChartDataEntry(x: receipt.date.timeIntervalSince1970, y: Double(receipt.price))
            )
        }
        
        
        let set1 = LineChartDataSet(entries: yValues, label: "Subscribes")
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier //отвечает за плавность линии
        set1.lineWidth = 3
        set1.setColor(.white)
        set1.fill = Fill(color: .white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true //заливка графика
        set1.drawHorizontalHighlightIndicatorEnabled = true //не обязательно
        set1.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
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


class ChartXAxisFormatter: NSObject {
    var dateFormatter: DateFormatter?
}

extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if let dateFormatter = dateFormatter {

            let date = Date(timeIntervalSince1970: value)
            return dateFormatter.string(from: date)
        }

        return ""
    }

}
*/
