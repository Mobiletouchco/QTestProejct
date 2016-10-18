//
//  LunchScreenController.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "LunchScreenController.h"
#import "UserObject.h"

@interface LunchScreenController ()

@end

@implementation LunchScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (isUserLoggedIn) {
        [[UserObject sharedUser] retriveUserFromLocal];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"] animated:NO];
    }
    else {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
