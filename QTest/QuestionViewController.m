//
//  QuestionViewController.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "QuestionViewController.h"
#import "UserObject.h"
#import "APIManager.h"
#import <TSMessages/TSMessage.h>
#import "ResultViewController.h"

#define TotalQuestion 90

@interface QuestionViewController () {
    
    __weak IBOutlet UIButton *trueBtn;
    __weak IBOutlet UIButton *falseBtn;
    __weak IBOutlet UIButton *nextBtn;
    __weak IBOutlet UILabel *quesLbl;
    __weak IBOutlet UIProgressView *progressBar;
    __weak IBOutlet UIButton *sendResultBtn;

    NSUInteger index;
    Question *currentQues;
    BOOL isResultAvailable;

}

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    index = 0;
    nextBtn.backgroundColor = DisableAppearanceColor;
    progressBar.progress = 0;
    [self requestForQuestion];

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestForQuestion {
    [self.view endEditing:YES];

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[UserObject sharedUser].userId forKey:@"user_id"];
    [param setValue:@(index) forKey:@"off_set"];
    [param setValue:@(1+[UserObject sharedUser].testTakenCount.integerValue) forKey:@"qtest_try"];
    if (currentQues == nil) {
        [param setValue:@"" forKey:@"question_id"];
        [param setValue:@0 forKey:@"question_answer"];
    }
    else {
        [param setValue:currentQues.questionId forKey:@"question_id"];
        [param setValue:@(currentQues.answer) forKey:@"question_answer"];
    }
    [[APIManager sharedManager] executePostRequestWith:@"questionlist" Parameters:param ForSuccess:^(id response) {
        if ([response valueForKey:@"results"]) {
            currentQues = [[Question alloc] initWithData:[response valueForKey:@"results"]];
            [self refreshQuestion];
        }
        else {
            [UserObject sharedUser].container.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
            [nextBtn setTitle:@"إنهاء" forState:UIControlStateNormal];
            isResultAvailable = YES;
            sendResultBtn.hidden = NO;
        }
    } ForFail:^(NSString *error) {
        [TSMessage showNotificationWithTitle:error type:TSMessageNotificationTypeError];
    }];
}

- (void)refreshQuestion {
    trueBtn.superview.hidden = NO;
    quesLbl.text = currentQues.questionText;
    trueBtn.selected = falseBtn.selected = NO;
    index += 1;
    nextBtn.backgroundColor = DisableAppearanceColor;
    nextBtn.enabled = NO;
    float result = (float)index / TotalQuestion;
    progressBar.progress = result;
}

- (IBAction)tapAnswer:(UIButton*)sender {
    if (sender == trueBtn) {
        trueBtn.selected = YES;
        falseBtn.selected = NO;
        currentQues.answer = 1;
    }
    else {
        trueBtn.selected = NO;
        falseBtn.selected = YES;
        currentQues.answer = 0;
    }
    nextBtn.enabled = YES;
    nextBtn.backgroundColor = AppAppearanceColor;

}
- (IBAction)nextAct:(UIButton*)sender {
    index = TotalQuestion;
    if (isResultAvailable) {
        ResultViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
        vc.willSendResult = [@(sender.tag) boolValue];
        [UserObject sharedUser].container.centerViewController = vc;
    }
    else {
        [self requestForQuestion];
    }
}

@end
