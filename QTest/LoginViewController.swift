//
//  LoginViewController.swift
//  QTest
//
//  Created by TM Mac 01 on 10/13/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit
import TSMessages

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameFld: UITextField!
    @IBOutlet weak var passwordFld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userNameFld.text = "shah"
        passwordFld.text = "123456"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goForward() {
        if userNameFld.text?.isEmpty == true || passwordFld.text?.isEmpty == true {
            TSMessage.showNotification(withTitle: "Required field should not be empty.", type: .error)
            return
        }
        guard (passwordFld.text?.characters.count)! > 5 else {
            TSMessage.showNotification(withTitle: "Password should be minimum 6 characters.", type: .error)
            return
        }
        
        let param: [String: Any] = [
            "password": passwordFld.text,
            "user_name": userNameFld.text,
        ]
        
        APIManager.sharedInstance.executePostRequest(urlString: "login", parameters: param, Success: { (response) in
            UserObject.sharedUser.saveUserToLocal(info: response.value(forKey: "results") as! NSDictionary)
            self.performSegue(withIdentifier: String(describing: WelcomeViewController.self), sender: nil)
            
        }) { (error) in
            TSMessage.showNotification(withTitle: error, type: .error)
        }    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == userNameFld) {
            passwordFld.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
            goForward()
        }
        return true
    }
}
