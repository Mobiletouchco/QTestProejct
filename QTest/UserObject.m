//
//  UserObject.m
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#import "UserObject.h"

static UserObject *Shared = nil;

@implementation UserObject

+ (UserObject*) sharedUser {
    if (Shared==nil) {
        Shared = [[UserObject alloc] init];
        //        NSLog(@"creating user.............");
    }
    return Shared;
}

- (instancetype)initWithData:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (dictionary.allKeys > 0) {
            _userId = dictionary[@"user_id"];
            _userName = dictionary[@"user_name"];
            _testTakenCount = dictionary[@"test_taken_count"];
            _firstName = dictionary[@"first_name"];
            _email = dictionary[@"email"];
            if (dictionary[@"contact_number"]) {
                _contactNumber = dictionary[@"contact_number"];
            }
            _isAdmin = [dictionary[@"is_admin"] boolValue];
        }
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]) {
        _userId = [decoder decodeObjectForKey:@"user_id"];
        _userName = [decoder decodeObjectForKey:@"user_name"];
        _testTakenCount = [decoder decodeObjectForKey:@"test_taken_count"];
        _firstName = [decoder decodeObjectForKey:@"first_name"];
        _email = [decoder decodeObjectForKey:@"email"];
        _contactNumber = [decoder decodeObjectForKey:@"contact_number"];
        _isAdmin = [[decoder decodeObjectForKey:@"is_admin"] boolValue];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userId forKey:@"user_id"];
    [aCoder encodeObject:_userName forKey:@"user_name"];
    [aCoder encodeObject:_testTakenCount forKey:@"test_taken_count"];
    [aCoder encodeObject:_firstName forKey:@"first_name"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_contactNumber forKey:@"contact_number"];
    [aCoder encodeObject:@(_isAdmin) forKey:@"is_admin"];
}

- (void)saveUserToLocalWithInfo:(NSDictionary*)info {
    UserObject *user = [[UserObject alloc] initWithData:info];
    _userId = user.userId;
    _userName = user.userName;
    _firstName = user.firstName;
    _email = user.email;
    _contactNumber = user.contactNumber;
    _testTakenCount = user.testTakenCount;
    _isAdmin = user.isAdmin;
    
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [USERDEFAULTS setObject:encodedData forKey:kStringSavedUserKey];
    [USERDEFAULTS setBool:YES forKey:kStringLoginKey];
    [USERDEFAULTS synchronize];
}
- (void)retriveUserFromLocal {
    NSData * data = [USERDEFAULTS objectForKey:kStringSavedUserKey];
    UserObject *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    _userId = user.userId;
    _userName = user.userName;
    _firstName = user.firstName;
    _email = user.email;
    _contactNumber = user.contactNumber;
    _testTakenCount = user.testTakenCount;
    _isAdmin = user.isAdmin;
}

- (void)createContainerWithCentre:(UIViewController*)centreVC {
//    _container = [MFSideMenuContainerViewController containerWithCenterViewController:centreVC leftMenuViewController:nil rightMenuViewController:MenuItemsViewController.new];
//    _container.panMode = MFSideMenuPanModeNone;
//    _container.navigationItem.hidesBackButton = YES;
}

+ (BOOL)isValidEmail:(NSString*)email {
    NSPredicate *emailValidator = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@",
                                   @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
                                   @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
                                   @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
                                   @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
                                   @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
                                   @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
                                   @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"];
    
    BOOL success = [emailValidator evaluateWithObject:email];
    return success;
}
@end


@implementation Question

- (instancetype)initWithData:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (dictionary.allKeys > 0) {
            _questionId = dictionary[@"question_id"];
            _questionText = dictionary[@"question_text"];
        }
    }
    return self;
}


@end


@implementation Category

- (instancetype)initWithData:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (dictionary.allKeys > 0) {
            _categoryId = dictionary[@"category_id"];
            _categoryTitle = dictionary[@"category_title"];
            _totalQuestions = dictionary[@"total_questions"];
            _totalCorrectAnswers = dictionary[@"total_correct_answers"];
            switch (_categoryId.integerValue) {
                case 2:
                    _bgColor = [UIColor colorWithRed:0.91 green:0.71 blue:0.35 alpha:1.00];
                    break;
                case 3:
                    _bgColor = [UIColor colorWithRed:0.55 green:0.76 blue:0.39 alpha:1.00];
                    break;
                case 4:
                    _bgColor = [UIColor colorWithRed:0.13 green:0.57 blue:0.65 alpha:1.00];
                    break;
                case 5:
                    _bgColor = [UIColor colorWithRed:0.51 green:0.68 blue:0.80 alpha:1.00];
                    break;
                case 6:
                    _bgColor = [UIColor colorWithRed:0.39 green:0.30 blue:0.58 alpha:1.00];
                    break;
                default:
                    _bgColor = [UIColor colorWithRed:0.82 green:0.32 blue:0.27 alpha:1.00];
                    break;
            }
        }
    }
    return self;
}

@end
