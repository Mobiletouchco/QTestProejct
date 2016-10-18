//
//  LoginViewController.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "LoginViewController.h"
#import <TSMessages/TSMessage.h>
#import "APIManager.h"
#import "UserObject.h"

@interface LoginViewController ()<UITextFieldDelegate> {
    __weak IBOutlet UITextField *userNameFld;
    __weak IBOutlet UITextField *passwordFld;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)goForward {
    [self.view endEditing:YES];
    if (userNameFld.text.length < 1) {
        [TSMessage showNotificationWithTitle:@"Required field should not be empty." type:TSMessageNotificationTypeError];
        return;
    }
    if (passwordFld.text.length < 6) {
        [TSMessage showNotificationWithTitle:@"Password should be minimum 6 characters." type:TSMessageNotificationTypeError];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:userNameFld.text forKey:@"user_name"];
    [param setValue:passwordFld.text forKey:@"password"];
    [[APIManager sharedManager] executePostRequestWith:@"login" Parameters:param ForSuccess:^(id response) {
        if ([response valueForKey:@"results"]) {
            [[UserObject sharedUser] saveUserToLocalWithInfo:[response valueForKey:@"results"]];
            [self performSegueWithIdentifier:@"WelcomeViewController" sender:nil];
        }
    } ForFail:^(NSString *error) {
        [TSMessage showNotificationWithTitle:error type:TSMessageNotificationTypeError];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == userNameFld) {
        [passwordFld becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
        [self goForward];
    }
    return YES;
}

@end
