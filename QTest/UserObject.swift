//
//  UserObject.swift
//  Dollars
//
//  Created by Shah Newaz Hossain on 8/27/16.
//  Copyright © 2016 ShahNewaz. All rights reserved.
//

import UIKit

class UserObject: NSObject {
    
    var userId: String = ""
    var userName: String = ""
    var firstName: String = ""
    var testTakenCount: NSNumber = 0
    var email: String = ""
    var contactNumber: String?

    static let sharedUser : UserObject = {
        let instance = UserObject()
        return instance
    }()
    
    
    convenience init(_ dictionary: NSDictionary) {
        self.init()
        userId = ((dictionary["user_id"] as AnyObject).stringValue)!
        userName = dictionary["user_name"] as! String
        testTakenCount = dictionary["test_taken_count"] as! NSNumber
        firstName = dictionary["first_name"] as! String
        email = dictionary["email"] as! String
        if let contact_number = dictionary["contact_number"] as? String {
            contactNumber = contact_number
        }
    }
    
    func saveUserToLocal(info: NSDictionary) {
        USERDEFAULTS.set(info, forKey: kStringSavedUserKey)
        USERDEFAULTS.set(true, forKey: kStringLoginKey)
        USERDEFAULTS.synchronize()
        
        let user = UserObject.init(info)
        userId = user.userId
        userName = user.userName
        firstName = user.firstName
        email = user.email
        contactNumber = user.contactNumber
        testTakenCount = user.testTakenCount
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
//    func isValidPhoneNumber(value: String) -> Bool {
//        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: value)
//        return result
//    }
}

//class ChatRoom: NSObject {
//    
//    var userId: String = ""
//    var roomId: String = ""
//    var name: String = ""
//    var total_member_online: NSNumber = 0
//    var isPrivate: Bool = false
////    var password: String = ""
//
//    convenience init(_ dictionary: NSDictionary) {
//        self.init()
//        roomId = dictionary["id"]!.stringValue
//        userId = dictionary["user_id"]!.stringValue
//        name = dictionary["name"] as! String
//        total_member_online = dictionary["total_member_online"] as! NSNumber
////        password = dictionary["password"] as! String
////        room_type = dictionary["room_type"] as! String
//        if dictionary["room_type"]!.isEqualToString("private") {
//            isPrivate = true
//        }
//    }
//    
//}

