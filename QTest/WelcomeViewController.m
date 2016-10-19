//
//  WelcomeViewController.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UserObject.h"
#import "RegisterViewController.h"

@interface WelcomeViewController () {
    __weak IBOutlet UILabel *fullNameLbl;

}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fullNameLbl.text = [UserObject sharedUser].firstName;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if ([UserObject sharedUser].willGoForTest) {
        [self goForward];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UpdateProfile"]) {
        RegisterViewController *vc = segue.destinationViewController;
        vc.isForUpdate = YES;
    }
}

- (void)toggleSideMenu:(id)sender {
    [[UserObject sharedUser].container toggleRightSideMenuCompletion:nil];
}

- (void)goBack {
    [USERDEFAULTS setBool:NO forKey:kStringLoginKey];
    [USERDEFAULTS synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)goForward {
    [[UserObject sharedUser] createContainerWithCentre:[self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"]];
    [UserObject sharedUser].container.title = @"مرحبا لإختبار الميول";
    [UserObject sharedUser].container.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleSideMenu:)];
    [self.navigationController pushViewController:[UserObject sharedUser].container animated:![UserObject sharedUser].willGoForTest];
    [UserObject sharedUser].willGoForTest = NO;
}

@end
