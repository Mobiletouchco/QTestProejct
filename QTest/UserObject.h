//
//  UserObject.h
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MFSideMenu/MFSideMenu.h>
#import "Constants.h"

@interface UserObject : NSObject<NSCoding>

@property (nonatomic, retain) MFSideMenuContainerViewController *container;
@property (nonatomic, assign) BOOL willGoForTest;

+ (UserObject*)sharedUser;
+ (BOOL)isValidEmail:(NSString*)email;

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *testTakenCount;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *contactNumber;
@property (nonatomic, assign) BOOL isAdmin;


- (instancetype)initWithData:(NSDictionary*)dictionary;
- (void)retriveUserFromLocal;
- (void)saveUserToLocalWithInfo:(NSDictionary*)info;
- (void)createContainerWithCentre:(UIViewController*)centreVC;

@end


@interface Question : NSObject

@property (nonatomic, retain) NSString *questionId;
@property (nonatomic, assign) NSInteger answer;
@property (nonatomic, retain) NSString *questionText;

- (instancetype)initWithData:(NSDictionary*)dictionary;

@end

@interface Category : NSObject

@property (nonatomic, retain) NSString *categoryId;
@property (nonatomic, retain) NSString *categoryTitle;
@property (nonatomic, retain) UIColor *bgColor;
@property (nonatomic, retain) NSNumber *totalQuestions;
@property (nonatomic, retain) NSNumber *totalCorrectAnswers;


- (instancetype)initWithData:(NSDictionary*)dictionary;

@end
