//
//  UserObject.swift
//  Dollars
//
//  Created by Shah Newaz Hossain on 8/27/16.
//  Copyright © 2016 ShahNewaz. All rights reserved.
//

import UIKit
import MFSideMenu

class UserObject: NSObject, NSCoding {
    
    var userId: String = ""
    var userName: String = ""
    var firstName: String = ""
    var testTakenCount: String = ""
    var email: String = ""
    var contactNumber: String = ""

    var container: MFSideMenuContainerViewController? = nil
    var willGoForTest: Bool = false

    static let sharedUser : UserObject = {
        let instance = UserObject()
        return instance
    }()
    
    func createContainer(centreVC: UIViewController) {
        container = MFSideMenuContainerViewController.container(withCenter: centreVC, leftMenuViewController: nil, rightMenuViewController: MenuItemsViewController())
        container?.panMode = MFSideMenuPanModeNone
        container?.navigationItem.hidesBackButton = true
    }
    
    convenience init(_ dictionary: NSDictionary) {
        self.init()
        guard dictionary.allKeys.count>0 else {
            return
        }
        userId = dictionary["user_id"] as! String
        userName = dictionary["user_name"] as! String
        testTakenCount = dictionary["test_taken_count"] as! String
        firstName = dictionary["first_name"] as! String
        email = dictionary["email"] as! String
        if let contact_number = dictionary["contact_number"] as? String {
            contactNumber = contact_number
        }
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "user_id")
        aCoder.encode(userName, forKey: "user_name")
        aCoder.encode(testTakenCount, forKey: "test_taken_count")
        aCoder.encode(firstName, forKey: "first_name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(contactNumber, forKey: "contact_number")
    }
    
    
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        userId = decoder.decodeObject(forKey: "user_id") as! String
        userName = decoder.decodeObject(forKey: "user_name") as! String
        testTakenCount = decoder.decodeObject(forKey: "test_taken_count") as! String
        firstName = decoder.decodeObject(forKey: "first_name") as! String
        email = decoder.decodeObject(forKey: "email") as! String
        contactNumber = decoder.decodeObject(forKey: "contact_number") as! String
    }
    
    
    func saveUserToLocal(info: NSDictionary) {
        let user = UserObject.init(info)
        userId = user.userId
        userName = user.userName
        firstName = user.firstName
        email = user.email
        contactNumber = user.contactNumber
        testTakenCount = user.testTakenCount

        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
        USERDEFAULTS.set(encodedData, forKey: kStringSavedUserKey)
        USERDEFAULTS.set(true, forKey: kStringLoginKey)
        USERDEFAULTS.synchronize()
        
    }
    
    func retriveUserFromLocal() {
        let data = USERDEFAULTS.value(forKey: kStringSavedUserKey) as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: data) as! UserObject
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

class Question: NSObject {

    var questionId: String = ""
    var answer: Int?
    var questionText: String = ""

    convenience init(_ dictionary: NSDictionary) {
        self.init()
        questionId = dictionary["question_id"] as! String
        questionText = dictionary["question_text"] as! String
    }

}

class Category: NSObject {
    
    var categoryId: String = ""
    var categoryTitle: String = ""
    var totalCorrectAnswers: NSNumber = 0
    var totalQuestions: NSNumber = 0
    var bgColor: UIColor = UIColor.lightGray

    convenience init(_ dictionary: NSDictionary) {
        self.init()
        categoryId = dictionary["category_id"] as! String
        categoryTitle = dictionary["category_title"] as! String
        totalCorrectAnswers = dictionary["total_correct_answers"] as! NSNumber
        totalQuestions = dictionary["total_questions"] as! NSNumber
        
//        let cid = NumberFormatter().number(from: categoryId)
        switch categoryId {
        case "2":
            bgColor = UIColor(red:0.10, green:0.64, blue:0.11, alpha:1.00)
            break
        case "3":
            bgColor = UIColor(red:0.99, green:0.96, blue:0.21, alpha:1.00)
            break
        case "4":
            bgColor = UIColor(red:0.33, green:0.16, blue:0.45, alpha:1.00)
            break
        case "5":
            bgColor = UIColor(red:0.86, green:0.38, blue:0.13, alpha:1.00)
            break
        case "6":
            bgColor = UIColor(red:0.20, green:0.44, blue:0.71, alpha:1.00)
            break
        default:
            bgColor = UIColor(red:0.99, green:0.05, blue:0.11, alpha:1.00)
            break
        }
    }
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(categoryId, forKey: "user_id")
//        aCoder.encode(userName, forKey: "user_name")
//        aCoder.encode(categoryTitle, forKey: "test_taken_count")
//        aCoder.encode(totalCorrectAnswers, forKey: "first_name")
//        aCoder.encode(totalQuestions, forKey: "email")
//        aCoder.encode(contactNumber, forKey: "contact_number")
//    }
//    
//    
//    
//    required convenience init(coder decoder: NSCoder) {
//        self.init()
//        userId = decoder.decodeObject(forKey: "user_id") as! String
//        userName = decoder.decodeObject(forKey: "user_name") as! String
//        testTakenCount = decoder.decodeObject(forKey: "test_taken_count") as! String
//        firstName = decoder.decodeObject(forKey: "first_name") as! String
//        email = decoder.decodeObject(forKey: "email") as! String
//        contactNumber = decoder.decodeObject(forKey: "contact_number") as! String
//    }
}

