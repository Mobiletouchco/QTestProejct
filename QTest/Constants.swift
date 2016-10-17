//
//  Constants.swift
//  Dollars
//
//  Created by Shah Newaz Hossain on 8/28/16.
//  Copyright © 2016 ShahNewaz. All rights reserved.
//

import Foundation
import UIKit

let USERDEFAULTS = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let kStringLoginKey = "StringLoginKey"
let isUserLoggedIn = USERDEFAULTS.bool(forKey: kStringLoginKey)
let AppAppearanceColor = UIColor(red:0.92, green:0.30, blue:0.15, alpha:1.00)
let DisableAppearanceColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.00)
let kStringSavedUserKey = "StringSavedUserKey"
//let UserAccessToken = USERDEFAULTS.valueForKey(kStringAccessTokenKey) as! String
//let kStringUserNameKey = "StringUserNameKey"
//let kStringUserPictureKey = "StringUserPictureKey"
//let kStringUserIdKey = "StringUserIdKey"

