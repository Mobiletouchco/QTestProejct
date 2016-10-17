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
    
    @IBOutlet weak var barChart: PNBarChart!
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
    }
    
    
    
    func createBarChart() {
        let barChartFormatter = NumberFormatter()
        barChartFormatter.numberStyle = .currency
        barChartFormatter.allowsFloats = false
        barChartFormatter.maximumFractionDigits = 0

//        self.barChart =  {yValue in
//            return barChartFormatter.string(from: NSNumber(value: yValue))!
//        }
        self.barChart.backgroundColor = UIColor.clear
//        self.barChart.yLabelFormatter =  ({ (yValue: Float) -> (String) in
//            return barChartFormatter.string(from: NSNumber(value: yValue))!
//        })
        
        /*
         
         let bars: [ChartBarModel] = barModels.enumerated().map {index, barModel in
         return ChartBarModel(constant: ChartAxisValueDouble(index), axisValue1: zero, axisValue2: ChartAxisValueDouble(barModel.1), bgColor: color)
         }
         
         static NSNumberFormatter *barChartFormatter;
         if (!barChartFormatter){
         barChartFormatter = [[NSNumberFormatter alloc] init];
         barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
         barChartFormatter.allowsFloats = NO;
         barChartFormatter.maximumFractionDigits = 0;
         }
         self.titleLabel.text = @"Bar Chart";
         
         self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
         //        self.barChart.showLabel = NO;
         self.barChart.backgroundColor = [UIColor clearColor];
         self.barChart.yLabelFormatter = ^(CGFloat yValue){
         return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
         };
         
         self.barChart.yChartLabelWidth = 20.0;
         self.barChart.chartMarginLeft = 30.0;
         self.barChart.chartMarginRight = 10.0;
         self.barChart.chartMarginTop = 5.0;
         self.barChart.chartMarginBottom = 10.0;
         
         
         self.barChart.labelMarginTop = 5.0;
         self.barChart.showChartBorder = YES;
         [self.barChart setXLabels:@[@"2",@"3",@"4",@"5",@"2",@"3",@"4",@"5"]];
         //       self.barChart.yLabels = @[@-10,@0,@10];
         //        [self.barChart setYValues:@[@10000.0,@30000.0,@10000.0,@100000.0,@500000.0,@1000000.0,@1150000.0,@2150000.0]];
         [self.barChart setYValues:@[@10.82,@1.88,@6.96,@33.93,@10.82,@1.88,@6.96,@33.93]];
         [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNGreen,PNRed,PNGreen]];
         self.barChart.isGradientShow = NO;
         self.barChart.isShowNumbers = NO;
         
         [self.barChart strokeChart];
         self.barChart.delegate = self;
 */
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
