//
//  RegisterViewController.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "RegisterViewController.h"
#import "APIManager.h"
#import <TSMessages/TSMessage.h>
#import "UserObject.h"

@interface RegisterViewController ()<UITextFieldDelegate> {
    __weak IBOutlet UITextField *nameFld;
    __weak IBOutlet UITextField *userNameFld;
    __weak IBOutlet UITextField *passwordFld;
    __weak IBOutlet UITextField *emailFld;
    __weak IBOutlet UITextField *numberFld;
    
    
    __weak IBOutlet UIButton *backBtn;
    __weak IBOutlet UIButton *submitBtn;
    

}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_isForUpdate) {
        UserObject *user = [UserObject sharedUser];
        userNameFld.text = user.userName;
        nameFld.text = user.firstName;
        emailFld.text = user.email;
//        numberFld.text = user.contactNumber;
        userNameFld.enabled = NO;
        
        [submitBtn setTitle:@"تحديث" forState:UIControlStateNormal];
        [backBtn setTitle:@"الى الخلف" forState:UIControlStateNormal];

        //
    }
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
    if (nameFld.text.length < 1 || userNameFld.text.length < 1 || emailFld.text.length < 1) {
        [TSMessage showNotificationWithTitle:@"Required field should not be empty." type:TSMessageNotificationTypeError];
        return;
    }
    if (![UserObject isValidEmail:emailFld.text]) {
        [TSMessage showNotificationWithTitle:@"Email address is not valid." type:TSMessageNotificationTypeError];
        return;
    }
    if (passwordFld.text.length < 6) {
        [TSMessage showNotificationWithTitle:@"Password should be minimum 6 characters." type:TSMessageNotificationTypeError];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *url = @"registration";
    if (_isForUpdate) {
        url = @"updateprofile";
        [param setValue:[UserObject sharedUser].userId forKey:@"user_id"];
    }
    else {
        [param setValue:[[UIDevice currentDevice] identifierForVendor].UUIDString forKey:@"device_id"];
        [param setValue:@1 forKey:@"device_type"];
    }
    [param setValue:emailFld.text forKey:@"email"];
    [param setValue:userNameFld.text forKey:@"user_name"];
    [param setValue:passwordFld.text forKey:@"password"];
    [param setValue:nameFld.text forKey:@"first_name"];
    [param setValue:numberFld.text forKey:@"contact_number"];

    [[APIManager sharedManager] executePostRequestWith:url Parameters:param ForSuccess:^(id response) {
        if ([response valueForKey:@"results"]) {
            [[UserObject sharedUser] saveUserToLocalWithInfo:[response valueForKey:@"results"]];
            if (_isForUpdate) {
                [self goBack];
                [TSMessage showNotificationWithTitle:[response valueForKey:@"msg"] type:TSMessageNotificationTypeSuccess];
            }
            else {
                [self performSegueWithIdentifier:@"WelcomeViewController" sender:nil];
            }
        }

    } ForFail:^(NSString *error) {
        [TSMessage showNotificationWithTitle:error type:TSMessageNotificationTypeError];
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == userNameFld || textField == passwordFld) {
        if ([string rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].location != NSNotFound) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == nameFld) {
        [userNameFld becomeFirstResponder];
    }
    else if (textField == userNameFld) {
        [passwordFld becomeFirstResponder];
    }
    else if (textField == passwordFld) {
        [emailFld becomeFirstResponder];
    }
    else if (textField == emailFld) {
        [numberFld becomeFirstResponder];
        //            goForward()
    }
    else {
        [textField resignFirstResponder];
    }

    return YES;
}

@end
