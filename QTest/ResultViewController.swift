//
//  ResultViewController.swift
//  QTest
//
//  Created by TM iMac on 10/17/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit
import TSMessages
import SwiftCharts
import PNChart


class ResultViewController: UIViewController {
    
    @IBOutlet weak var barChartView: UIView!
    var barChart = PNBarChart()
    
    var results: NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        requestForResult()
        
//        let chartConfig = BarsChartConfig(
//            valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
//        )
//        
//        let chart = BarsChart(
//            frame: barChartContainer.bounds,
//            chartConfig: chartConfig,
//            xTitle: "X axis",
//            yTitle: "Y axis",
//            bars: [
//                ("A", 2),
//                ("B", 4.5),
//                ("C", 3),
//                ("D", 5.4),
//                ("E", 6.8),
//                ("F", 0.5)
//            ],
//            color: UIColor.red,
//            barWidth: 20
//        )
//        barChartContainer.addSubview(chart.view)
        createBarChart()
    }
    
//    func yLabelFormatter(yValue: CGFloat, Failure: @escaping PNYLabelFormatter) -> String {
//        let barChartFormatter = NumberFormatter()
//        barChartFormatter.numberStyle = .currency
//        barChartFormatter.allowsFloats = false
//        barChartFormatter.maximumFractionDigits = 0
//        Failure(yValue)
//        return barChartFormatter.string(from: NSNumber(value: yValue))
//    }
    
    func createBarChart() {
//        let barChartFormatter = NumberFormatter()
//        barChartFormatter.numberStyle = .currency
//        barChartFormatter.allowsFloats = false
//        barChartFormatter.maximumFractionDigits = 0


//        self.barChart.yLabelFormatter = { (yValue) in
//            barChartFormatter.string(from: NSNumber(value: yValue))
//        }
//        self.barChart.frame = PNBarChart
//        barChart = PNBarChart(frame: CGRect(x: 0, y: 0, width: 768, height: 352))
        
        
        

        
        self.barChart.backgroundColor = UIColor.clear

        self.barChart.yChartLabelWidth = 20.0
        self.barChart.chartMarginLeft = 30.0
        self.barChart.chartMarginRight = 10.0
        self.barChart.chartMarginTop = 5.0
        self.barChart.chartMarginBottom = 10.0

        self.barChart.labelMarginTop = 5.0
        self.barChart.showChartBorder = true;
        self.barChart.xLabels = ["2","3","4","5","2","3","4","5","2","3","4","5","2","3","4","5"]
        self.barChart.yValues = [10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93]
        self.barChart.strokeColors = [UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green]

        self.barChart.isGradientShow = false
        self.barChart.isShowNumbers = false
        
        self.barChart.stroke()
        
        barChartView.addSubview(self.barChart)
        barChart.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 768)
        let heightConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 352)
        barChartView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

//        let topConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
//        let bottomConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
//        let leadConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
//        let tailConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
//        barChartView.addConstraints([topConstraint, bottomConstraint, leadConstraint, tailConstraint])

//        barChartView.updateConstraintsIfNeeded()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func requestForResult() {
        let param: [String: Any] = [
            "user_id": UserObject.sharedUser.userId,
        ]

        APIManager.sharedInstance.executePostRequest(urlString: "finalresult", parameters: param, Success: { (response) in
            guard response.value(forKey: "results") == nil else {
                let list = response.value(forKey: "results") as! NSArray
                for info in list {
                    self.results.add(Category(info as! NSDictionary))
                }
//                self.currentQues = Question(response.value(forKey: "results") as! NSDictionary)
//                self.refreshQuestion()
                return
            }
            
            //            self.navigationController?.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController"))!, animated: true)
            
        }) { (error) in
            TSMessage.showNotification(withTitle: error, type: .error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
