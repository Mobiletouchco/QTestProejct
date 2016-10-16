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
//let AppAppearanceColor = UIColor(red: 150.0/255.0, green: 5.0/255.0, blue: 23.0/255.0, alpha: 1.0)
let kStringSavedUserKey = "StringSavedUserKey"
//let UserAccessToken = USERDEFAULTS.valueForKey(kStringAccessTokenKey) as! String
//let kStringUserNameKey = "StringUserNameKey"
//let kStringUserPictureKey = "StringUserPictureKey"
//let kStringUserIdKey = "StringUserIdKey"

