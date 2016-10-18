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
    @IBOutlet weak var pieChartView: UIView!
    var pieChart = PNPieChart()
    
    var results: NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "نتيجتك في الإختبار"
        requestForResult()

//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: self, action: #selector(toggleSideMenu(sender:)))

    }
    
    func toggleSideMenu(sender: UIBarButtonItem) {
        UserObject.sharedUser.container?.toggleRightSideMenuCompletion({
            
        })
    }
    
    func createPieChart() {
        let items = NSMutableArray()
        for cat in results {
            let category = cat as! Category
            if category.totalCorrectAnswers.intValue > 0 {
                items.add(PNPieChartDataItem(value: CGFloat(category.totalCorrectAnswers), color: category.bgColor, description: category.categoryTitle))
            }
        }
//        items.add(PNPieChartDataItem(value: 10, color: UIColor.red, description: ""))
//        items.add(PNPieChartDataItem(value: 10, color: UIColor.green, description: "WWDC"))
//        items.add(PNPieChartDataItem(value: 10, color: UIColor.orange, description: "GOOG I/O"))

        let screenSize: CGRect = UIScreen.main.bounds
        var maxSize = screenSize.width
        if maxSize > screenSize.height {
            maxSize = screenSize.height
        }
        self.pieChart = PNPieChart(frame: CGRect(x: 0, y: 0, width: (maxSize-100)/2, height: (maxSize-100)/2), items: items as [AnyObject])
        self.pieChart.backgroundColor = UIColor.clear
        pieChartView.addSubview(self.pieChart)
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: pieChartView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: pieChartView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (maxSize-100)/2)
        let heightConstraint = NSLayoutConstraint(item: pieChart, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (maxSize-100)/2)
        pieChartView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        self.pieChart.descriptionTextColor = UIColor.white
        self.pieChart.descriptionTextFont  = UIFont(name: "Avenir-Medium", size: 18)
        self.pieChart.descriptionTextShadowColor = UIColor.clear
        self.pieChart.showAbsoluteValues = false
        self.pieChart.showOnlyValues = true
        self.pieChart.stroke()

//        self.pieChart.legendStyle = .stacked
//        self.pieChart.legendFont = UIFont.boldSystemFont(ofSize: 14)
//        let legend = self.pieChart.getLegendWithMaxWidth(200)
//        [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
//        [self.view addSubview:legend];
    }
    
    func createBarChart() {
//        let barChartFormatter = NumberFormatter()
//        barChartFormatter.numberStyle = .currency
//        barChartFormatter.allowsFloats = false
//        barChartFormatter.maximumFractionDigits = 0


//        self.barChart.yLabelFormatter = { (yValue) in
//            barChartFormatter.string(from: NSNumber(value: yValue))
//        }
        
        let screenSize: CGRect = UIScreen.main.bounds
        var maxSize = screenSize.width
        if maxSize > screenSize.height {
            maxSize = screenSize.height
        }
        
//        self.barChart.frame = PNBarChart
        barChart = PNBarChart(frame: CGRect(x: 0, y: 0, width: maxSize, height: (maxSize-64)/2))
        self.barChart.backgroundColor = UIColor.clear
        barChartView.addSubview(self.barChart)
        barChart.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: barChartView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: maxSize)
        let heightConstraint = NSLayoutConstraint(item: barChart, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (maxSize-64)/2)
        barChartView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])


        self.barChart.yChartLabelWidth = 20.0
        self.barChart.chartMarginLeft = 30.0
        self.barChart.chartMarginRight = 10.0
        self.barChart.chartMarginTop = 5.0
        self.barChart.chartMarginBottom = 10.0
        self.barChart.yMaxValue = 20
        self.barChart.labelMarginTop = 5.0
        self.barChart.showChartBorder = true;

        self.barChart.xLabels = results.value(forKey: "categoryTitle") as! [String] //["2","3","4","5","2","3","4","5","2","3","4","5","2","3","4","5"]
        self.barChart.yValues = results.value(forKey: "totalCorrectAnswers") as! [NSNumber]//[10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93]
        self.barChart.strokeColors = results.value(forKey: "bgColor") as! [UIColor]//[UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green]

        self.barChart.isGradientShow = false
        self.barChart.isShowNumbers = true
        
        self.barChart.stroke()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
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
                self.createBarChart()
//                self.createPieChart()
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
