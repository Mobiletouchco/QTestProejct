//
//  AdminViewController.m
//  QTest
//
//  Created by TM iMac on 10/19/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "AdminViewController.h"
@import Charts;
#import "APIManager.h"
#import "UserObject.h"
#import <TSMessages/TSMessage.h>

@interface AdminViewController ()<UITableViewDelegate, UITableViewDataSource> {
    
    __weak IBOutlet UITableView *userTable;
    
    __weak IBOutlet HorizontalBarChartView *barChartView;
    
    __weak IBOutlet UITextField *searchField;
    NSMutableArray *results, *userList;
    NSArray *searchList;
}

@property (nonatomic, strong) NSArray *months;
@property (nonatomic, assign) CGFloat sliderX;
@property (nonatomic, assign) CGFloat sliderY;

@end

@implementation AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"النتائج";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];

    results = [NSMutableArray array];
    userList = [NSMutableArray array];
    [self requestForUser];
    [self createBarChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestForUser {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[UserObject sharedUser].userId forKey:@"user_id"];
    [[APIManager sharedManager] executePostRequestWith:@"finalresultusers" Parameters:param ForSuccess:^(id response) {
        if ([response valueForKey:@"results"]) {
            for (NSDictionary *data in [response valueForKey:@"results"]) {
                [userList addObject:[[UserObject alloc] initWithData:data]];
            }
            searchList = [userList copy];
            [userTable reloadData];
        }
    } ForFail:^(NSString *error) {
        [TSMessage showNotificationWithTitle:error type:TSMessageNotificationTypeError];
    }];
}


- (void)requestForResultWithId:(NSString*)userId {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:userId forKey:@"user_id"];
    [[APIManager sharedManager] executePostRequestWith:@"finalresult" Parameters:param ForSuccess:^(id response) {
        if ([response valueForKey:@"results"]) {
            [results removeAllObjects];
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

- (IBAction)changeEditing:(UITextField *)sender {
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"restaurant.title CONTAINS[c] %@ OR restaurant.descriptionTags CONTAINS[c] %@ OR restaurant.addressLine CONTAINS[c] %@", sender.text,searchText,searchText,searchText];
    if (sender.text.length > 0) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF.firstName CONTAINS[c] %@", sender.text];
        searchList = [userList filteredArrayUsingPredicate:pred];
    }
    else {
        searchList = [userList copy];
    }
    [userTable reloadData];
}

- (void)createBarChart {
    
    _months = @[];
    [self setupBarLineChartView:barChartView];
//    barChartView.delegate = self;
    
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

    /*
//    barChartView.chartDescription.enabled = NO;
    barChartView.drawGridBackgroundEnabled = NO;
    barChartView.dragEnabled = YES;
    [barChartView setScaleEnabled:YES];
    barChartView.pinchZoomEnabled = NO;
    // ChartYAxis *leftAxis = chartView.leftAxis;
    barChartView.rightAxis.enabled = NO;
    barChartView.drawBarShadowEnabled = NO;
    barChartView.drawValueAboveBarEnabled = YES;
    barChartView.maxVisibleValueCount = 60;
    
    ChartXAxis *xAxis = barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
//    xAxis.granularity = 10.0;
    
    ChartYAxis *leftAxis = barChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis._axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = barChartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis._axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = barChartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 8.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;

    [barChartView animateWithYAxisDuration:2.5];
*/
}

- (void)setupBarLineChartView:(HorizontalBarChartView *)chartView {
    chartView.descriptionText = @"";
    chartView.drawGridBackgroundEnabled = NO;
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = NO;

    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    chartView.rightAxis.enabled = NO;
}

- (void)updateChartData {
//    if (self.shouldHideData)
//    {
//        _chartView.data = nil;
//        return;
//    }
    
    [self setDataCount:_sliderX + 1 range:_sliderY];
}



- (void)setDataCount:(int)count range:(double)range{
    
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

    /*
//    double barWidth = 9.0;
    double spaceForBar = 10.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult));
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i*spaceForBar]];
//        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:val]];
    }
    
    BarChartDataSet *set1 = nil;
    if (barChartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)barChartView.data.dataSets[0];
        set1.yVals = yVals;
        [barChartView.data notifyDataChanged];
        [barChartView notifyDataSetChanged];
    }
    else
    {
//        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
        set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"DataSet"];
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
//        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        BarChartData *data = [[BarChartData alloc] initWithXVals:yVals dataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
//        data.barWidth = barWidth;
        
        barChartView.data = data;
    }
    */
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return searchList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    UserObject *user = searchList[indexPath.row];
    cell.textLabel.text = user.firstName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UserObject *user = searchList[indexPath.row];
    [self requestForResultWithId:user.userId];
}
@end
