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
#import "UserObject.h"

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
        else {
            failure([responseObject valueForKey:@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        failure(error.localizedDescription);
        NSLog(@"Failure %@ : %@",urlString, error.localizedDescription);
    }];
}

- (void)sendResult:(UIImage*)image ForSuccess:(SuccessCompletionHandler)success ForFail:(FailureCompletionHandler)failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:SecurityCode forKey:@"security_code"];
    [param setValue:[UserObject sharedUser].userId forKey:@"user_id"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[BaseUrl stringByAppendingString:@"resultemail"] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1.0) name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg"];
    } error:nil];
    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                          hud.progress = uploadProgress.fractionCompleted;
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          [hud hideAnimated:YES];
                          failure(error.localizedDescription);
                          NSLog(@"Failure %@", error.localizedDescription);
                      } else {
                          [hud hideAnimated:YES];
                          if ([[responseObject valueForKey:@"success"] boolValue]) {
                              success(responseObject);
                          }
                          else {
                              failure([responseObject valueForKey:@"msg"]);
                          }
//                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}


@end
