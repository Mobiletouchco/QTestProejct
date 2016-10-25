//
//  ForgetPassViewController.m
//  QTest
//
//  Created by TM iMac on 10/19/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "UserObject.h"
#import "APIManager.h"
#import <TSMessages/TSMessage.h>

@interface ForgetPassViewController () {
    __weak IBOutlet UITextField *emailFld;

}

@end

@implementation ForgetPassViewController

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

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goForward {
    [self.view endEditing:YES];
    if (emailFld.text.length < 1) {
        [TSMessage showNotificationWithTitle:@"Required field should not be empty." type:TSMessageNotificationTypeError];
        return;
    }
    if (![UserObject isValidEmail:emailFld.text]) {
        [TSMessage showNotificationWithTitle:@"Email address is not valid." type:TSMessageNotificationTypeError];
        return;
    }

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:emailFld.text forKey:@"email"];
//    [param setValue:userNameFld.text forKey:@"user_name"];
//    [param setValue:passwordFld.text forKey:@"password"];
//    [param setValue:nameFld.text forKey:@"first_name"];
//    [param setValue:numberFld.text forKey:@"contact_number"];
    
    [[APIManager sharedManager] executePostRequestWith:@"forgetpassword" Parameters:param ForSuccess:^(id response) {
//        if ([response valueForKey:@"results"]) {
//            [[UserObject sharedUser] saveUserToLocalWithInfo:[response valueForKey:@"results"]];
//            [self performSegueWithIdentifier:@"WelcomeViewController" sender:nil];
//        }
        [self goBack];
        [TSMessage showNotificationWithTitle:[response valueForKey:@"msg"] type:TSMessageNotificationTypeSuccess];
    } ForFail:^(NSString *error) {
        [TSMessage showNotificationWithTitle:error type:TSMessageNotificationTypeError];
    }];
}


@end
