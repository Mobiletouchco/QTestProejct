//
//  Constants.h
//  QTest
//
//  Created by Shah Newaz Hossain on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import "AppDelegate.h"

#endif /* Constants_h */

#define appDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define USERDEFAULTS ([NSUserDefaults standardUserDefaults])

#define kStringLoginKey @"StringLoginKey"
#define kStringSavedUserKey @"StringSavedUserKey"

#define isUserLoggedIn ([USERDEFAULTS boolForKey:kStringLoginKey])

#define AppAppearanceColor ([UIColor colorWithRed:0.92 green:0.30 blue:0.15 alpha:1.00])
#define DisableAppearanceColor ([UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00])

