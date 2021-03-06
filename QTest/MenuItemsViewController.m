//
//  MenuItemsViewController.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "MenuItemsViewController.h"
#import "UserObject.h"

@interface MenuItemsViewController () {
    NSArray *menuList;
}

@end

@implementation MenuItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuList = @[@"الشاشة الرئيسية", @"إعادة اختبار", @"خروج"];
//    menuList = @["الشاشة الرئيسية"@, "إعادة اختبار", "خروج"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return menuList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
    }
    cell.textLabel.text = menuList[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[UserObject sharedUser].container toggleRightSideMenuCompletion:^{
        if (indexPath.row < 2) {
            [UserObject sharedUser].willGoForTest = [@(indexPath.row) boolValue];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else {
            [USERDEFAULTS setBool:NO forKey:kStringLoginKey];
            [USERDEFAULTS synchronize];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController popToRootViewControllerAnimated:NO];

        }
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
