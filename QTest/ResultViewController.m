//
//  ResultViewController.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "ResultViewController.h"
#import "UserObject.h"
#import "APIManager.h"
#import <TSMessages/TSMessage.h>
@import Charts;



@interface ResultViewController ()<ChartViewDelegate> {
    
    __weak IBOutlet BarChartView *barChartView;
    
    NSMutableArray *results;
}


@property (nonatomic, assign) BOOL shouldHideData;
@property (nonatomic, strong) NSArray *months;
@property (nonatomic, assign) CGFloat sliderX;
@property (nonatomic, assign) CGFloat sliderY;


@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"نتيجتك في الإختبار";
    results = [NSMutableArray array];
    [self requestForResult];
    [self createBarChart];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)toggleSideMenu:(id)sender {
    [[UserObject sharedUser].container toggleRightSideMenuCompletion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestForResult {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[UserObject sharedUser].userId forKey:@"user_id"];
    [[APIManager sharedManager] executePostRequestWith:@"finalresult" Parameters:param ForSuccess:^(id response) {
        if ([response valueForKey:@"results"]) {
            float xmax = -MAXFLOAT;
            float xmin = MAXFLOAT;
            for (NSDictionary *data in [response valueForKey:@"results"]) {
                [results addObject:[[Category alloc] initWithData:data]];
                float x = [[data valueForKey:@"total_questions"] floatValue];
                if (x < xmin) xmin = x;
                if (x > xmax) xmax = x;
            }
            _months = [results valueForKey:@"categoryTitle"];
            if (_months.count > 0) {
                _sliderX = _months.count-1;
            }
            else {
                _sliderX = 0;
            }
            _sliderY = xmax;
            [self updateChartData];
        }
    } ForFail:^(NSString *error) {
        [TSMessage showNotificationWithTitle:error type:TSMessageNotificationTypeError];
    }];
}

- (void)createBarChart {
    
    //    self.options = @[
    //                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
    //                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
    //                     @{@"key": @"toggleHighlightArrow", @"label": @"Toggle Highlight Arrow"},
    //                     @{@"key": @"animateX", @"label": @"Animate X"},
    //                     @{@"key": @"animateY", @"label": @"Animate Y"},
    //                     @{@"key": @"animateXY", @"label": @"Animate XY"},
    //                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
    //                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
    //                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
    //                     @{@"key": @"toggleData", @"label": @"Toggle Data"},
    //                     @{@"key": @"toggleBarBorders", @"label": @"Show Bar Borders"},
    //                     ];
    
    _months = @[];
//                //               @"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep",
//                //               @"Oct", @"Nov", @"Dec"
//                ];
    [self setupBarLineChartView:barChartView];
    
    barChartView.delegate = self;
    
    barChartView.drawBarShadowEnabled = NO;
    barChartView.drawValueAboveBarEnabled = YES;
    
    barChartView.maxVisibleValueCount = 60;
    
    ChartXAxis *xAxis = barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:14.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.spaceBetweenLabels = 2.0;
    
    ChartYAxis *leftAxis = barChartView.leftAxis;
    leftAxis.enabled = YES;
    leftAxis.labelFont = [UIFont systemFontOfSize:14.f];
    leftAxis.labelCount = 10;
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    leftAxis.valueFormatter.maximumFractionDigits = 0;
    
    //    leftAxis.valueFormatter.negativeSuffix = @" $";
    //    leftAxis.valueFormatter.positiveSuffix = @" $";
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinValue = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = barChartView.rightAxis;
    rightAxis.enabled = NO;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 10;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinValue = 0.0; // this replaces startAtZero = YES
    
    barChartView.legend.position = ChartLegendPositionBelowChartLeft;
    barChartView.legend.form = ChartLegendFormSquare;
    barChartView.legend.formSize = 9.0;
    barChartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    barChartView.legend.xEntrySpace = 4.0;
    barChartView.legend.enabled = NO;
    
    _sliderX = 0.0;
    _sliderY = 0.0;
    //    [self slidersValueChanged:nil];
    //    [self updateChartData];
    
    //    [self handleOption:@"toggleValues" forChartView:barChartView];
}
//{
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    CGFloat maxSize = screenSize.width;
//    if (maxSize > screenSize.height) {
//        maxSize = screenSize.height;
//    }
//    
//    //        self.barChart.frame = PNBarChart
//    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, maxSize, (maxSize-64))];
//    self.barChart.backgroundColor = [UIColor clearColor];
//    [barChartView addSubview:self.barChart];
//    
//    self.barChart.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:self.barChart attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:barChartView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:self.barChart attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:barChartView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.barChart attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:maxSize];
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.barChart attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:(maxSize-64)/2];
//    [barChartView addConstraints:@[horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint]];
//    
//    static NSNumberFormatter *barChartFormatter;
//    if (!barChartFormatter){
//        barChartFormatter = [[NSNumberFormatter alloc] init];
//        barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
//        barChartFormatter.allowsFloats = NO;
//        barChartFormatter.maximumFractionDigits = 0;
//    }
//    
//    //        self.barChart.showLabel = NO;
//    self.barChart.backgroundColor = [UIColor clearColor];
//    self.barChart.yLabelFormatter = ^(CGFloat yValue){
//        return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
//    };
//    
//    self.barChart.yChartLabelWidth = 20.0;
//    self.barChart.chartMarginLeft = 30.0;
//    self.barChart.chartMarginRight = 10.0;
//    self.barChart.chartMarginTop = 5.0;
//    self.barChart.chartMarginBottom = 10.0;
//    
//    
//    self.barChart.labelMarginTop = 5.0;
//    self.barChart.showChartBorder = YES;
//    [self.barChart setXLabels:@[@"2",@"3",@"4",@"5",@"2",@"3",@"4",@"5"]];
//    //       self.barChart.yLabels = @[@-10,@0,@10];
//    //        [self.barChart setYValues:@[@10000.0,@30000.0,@10000.0,@100000.0,@500000.0,@1000000.0,@1150000.0,@2150000.0]];
//    [self.barChart setYValues:@[@10.82,@1.88,@6.96,@33.93,@10.82,@1.88,@6.96,@33.93]];
//    [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNGreen,PNRed,PNGreen]];
//    self.barChart.isGradientShow = NO;
//    self.barChart.isShowNumbers = YES;
//    
//    [self.barChart strokeChart];
//
////    self.barChart.yChartLabelWidth = 20.0;
////    self.barChart.chartMarginLeft = 30.0;
////    self.barChart.chartMarginRight = 10.0;
////    self.barChart.chartMarginTop = 5.0;
////    self.barChart.chartMarginBottom = 10.0;
////    self.barChart.yMaxValue = 20;
////    self.barChart.labelMarginTop = 5.0;
////    self.barChart.showChartBorder = YES;
////    
////    self.barChart.xLabels = (NSArray*)[results valueForKey:@"categoryTitle"];
////    self.barChart.yValues = (NSArray*)[results valueForKey:@"totalCorrectAnswers"];
//////    self.barChart.yValues = @[10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93];
////    self.barChart.strokeColors = (NSArray*)[results valueForKey:@"bgColor"];//results.value(forKey: "bgColor") as! [UIColor]//[UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green,UIColor.green,UIColor.green,UIColor.red,UIColor.green]
////    NSLog(@"%@  %@",self.barChart.xLabels, self.barChart.yValues);
////    self.barChart.isGradientShow = NO;
////    self.barChart.isShowNumbers = NO;
////    [self.barChart strokeChart];
//}


#pragma mark - ChartView

- (void)updateChartData {
    if (self.shouldHideData) {
        barChartView.data = nil;
        return;
    }
    
    if (_sliderX == 0|| _sliderY == 0) {
        barChartView.data = nil;
        return;
        
    }
    
    [self setDataCount:(_sliderX + 1) range:_sliderY];
    
    //    for (id<IChartDataSet> set in barChartView.data.dataSets) {
    //        set.drawValuesEnabled = NO;
    //    }
    //    [barChartView setNeedsDisplay];
    
}
- (void)setDataCount:(int)count range:(double)range {
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        [xVals addObject:_months[i % _months.count]];
    }
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        //        double mult = (range + 1);
        //        double val =  (double) (arc4random_uniform(mult));
        Category *data = [results objectAtIndex:i];
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:data.totalCorrectAnswers.doubleValue xIndex:i]];
        [colors addObject:data.bgColor];
    }
    
    BarChartDataSet *set1 = nil;
    if (barChartView.data.dataSetCount > 0) {
        set1 = (BarChartDataSet *)barChartView.data.dataSets[0];
        set1.yVals = yVals;
        set1.valueFormatter = [[NSNumberFormatter alloc] init];
        set1.valueFormatter.maximumFractionDigits = 0;
        barChartView.data.xValsObjc = [results valueForKey:@"categoryTitle"];
        [barChartView.data notifyDataChanged];
        [barChartView notifyDataSetChanged];
    }
    else {
        set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"DataSet"];
        set1.barSpace = 0.35;
        [set1 setColors:colors];
        set1.valueFormatter = [[NSNumberFormatter alloc] init];
        set1.valueFormatter.maximumFractionDigits = 0;
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.f]];
        barChartView.data = data;
    }
}
- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView {
    chartView.descriptionText = @"";
    //    chartView.noDataTextDescription = @"You need to provide data for the chart.";
    
    chartView.drawGridBackgroundEnabled = NO;
    
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = NO;
    // ChartYAxis *leftAxis = chartView.leftAxis;
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    chartView.rightAxis.enabled = NO;
}


- (void)handleOption:(NSString *)key forChartView:(ChartViewBase *)chartView
{
    if ([key isEqualToString:@"toggleValues"])
    {
        for (id<IChartDataSet> set in chartView.data.dataSets)
        {
            set.drawValuesEnabled = !set.isDrawValuesEnabled;
        }
        
        [chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleHighlight"])
    {
        chartView.data.highlightEnabled = !chartView.data.isHighlightEnabled;
        [chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"animateX"])
    {
        [chartView animateWithXAxisDuration:3.0];
    }
    
    if ([key isEqualToString:@"animateY"])
    {
        [chartView animateWithYAxisDuration:3.0];
    }
    
    if ([key isEqualToString:@"animateXY"])
    {
        [chartView animateWithXAxisDuration:3.0 yAxisDuration:3.0];
    }
    
    if ([key isEqualToString:@"saveToGallery"])
    {
        [chartView saveToCameraRoll];
    }
    
    if ([key isEqualToString:@"togglePinchZoom"])
    {
        BarLineChartViewBase *barLineChart = (BarLineChartViewBase *)chartView;
        barLineChart.pinchZoomEnabled = !barLineChart.isPinchZoomEnabled;
        
        [chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleAutoScaleMinMax"])
    {
        BarLineChartViewBase *barLineChart = (BarLineChartViewBase *)chartView;
        barLineChart.autoScaleMinMaxEnabled = !barLineChart.isAutoScaleMinMaxEnabled;
        
        [chartView notifyDataSetChanged];
    }
    
    if ([key isEqualToString:@"toggleHighlightArrow"])
    {
        BarChartView *barChart = (BarChartView *)chartView;
        barChart.drawHighlightArrowEnabled = !barChart.isDrawHighlightArrowEnabled;
        
        [chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleData"])
    {
        _shouldHideData = !_shouldHideData;
        [self updateChartData];
    }
    
    if ([key isEqualToString:@"toggleBarBorders"])
    {
        for (id<IBarChartDataSet, NSObject> set in chartView.data.dataSets)
        {
            if ([set conformsToProtocol:@protocol(IBarChartDataSet)])
            {
                set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0;
            }
        }
        
        [chartView setNeedsDisplay];
    }
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight {
    
    NSLog(@"chartValueSelected  %ld",(long)entry.xIndex);
    //    barTopView.hidden = NO;
    
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
    //    barTopView.hidden = YES;
}

@end
