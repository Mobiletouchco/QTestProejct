//
//  RegisterViewController.swift
//  QTest
//
//  Created by TM Mac 01 on 10/13/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameFld: UITextField!
    @IBOutlet weak var userNameFld: UITextField!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var emailFld: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameFld.text = "Shah Newaz"
        userNameFld.text = "shah"
        passwordFld.text = "123456"
        emailFld.text = "s1@s.com"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func goForward() {
        let param: [String: Any] = [
            "device_id": UIDevice.current.identifierForVendor!.uuidString,
            "device_type": 1 as NSNumber,
            "email": emailFld.text,
            "password": passwordFld.text,
            "user_name": userNameFld.text,
            "first_name": nameFld.text
        ]
        
        APIManager.sharedInstance.executePostRequest(urlString: "registration", parameters: param, Success: { (response) in
            
            }) { (error) in
                
        }
        
//        self.performSegue(withIdentifier: String(describing: WelcomeViewController.self), sender: nil)
    }
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
        if (textField == nameFld) {
            userNameFld.becomeFirstResponder()
        }
        else if (textField == userNameFld) {
            passwordFld.becomeFirstResponder()
        }
        else if (textField == passwordFld) {
            emailFld.becomeFirstResponder()
        }
        else if (textField == emailFld) {
            textField.resignFirstResponder()
//            goForward()
        }
        return true
    }
    
}
