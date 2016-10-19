//
//  APIManager.h
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SuccessCompletionHandler)(id response);
typedef void (^FailureCompletionHandler)(NSString *error);

@interface APIManager : NSObject

+ (APIManager*) sharedManager;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)executePostRequestWith:(NSString*)urlString Parameters:(NSMutableDictionary*)parameters ForSuccess:(SuccessCompletionHandler)success ForFail:(FailureCompletionHandler)failure;
- (void)sendResult:(UIImage*)image ForSuccess:(SuccessCompletionHandler)success ForFail:(FailureCompletionHandler)failure;
@end
