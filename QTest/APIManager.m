//
//  APIManager.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "APIManager.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "Constants.h"

#define BaseUrl @"http://aujamtanmeyah.org.sa/qtest/"
#define SecurityCode @"api#100#qtest*786!#102"



static APIManager* sharedManger = nil;

@implementation APIManager {
    AFHTTPSessionManager *manager;

}

+ (APIManager*)sharedManager {
    
    if (!sharedManger) {
        sharedManger = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]];
    }
    
    return sharedManger;
}

- (instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super init]) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"application/json", nil]];
    }
    
    return self;
}

- (void)executePostRequestWith:(NSString*)urlString Parameters:(NSMutableDictionary*)parameters ForSuccess:(SuccessCompletionHandler)success ForFail:(FailureCompletionHandler)failure {
    [parameters setValue:SecurityCode forKey:@"security_code"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];
        NSLog(@"Success %@ : %@",urlString, responseObject);
        if ([[responseObject valueForKey:@"success"] boolValue]) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        failure(error.localizedDescription);
        NSLog(@"Failure %@ : %@",urlString, error.localizedDescription);
    }];
}

@end
