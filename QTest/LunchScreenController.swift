//
//  LunchScreenController.swift
//  QTest
//
//  Created by TM iMac on 10/18/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit

class LunchScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if USERDEFAULTS.bool(forKey: kStringLoginKey) {
            UserObject.sharedUser.retriveUserFromLocal()
            navigationController?.pushViewController((storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController"))!, animated: false)
//            self.performSegue(withIdentifier: String(describing: WelcomeViewController.self), sender: nil)
        }
        else {
//            self.performSegue(withIdentifier: String(describing: LoginViewController.self), sender: nil)
            navigationController?.pushViewController((storyboard?.instantiateViewController(withIdentifier: String(describing: LoginViewController.self)))!, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
