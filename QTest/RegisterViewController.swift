//
//  RegisterViewController.swift
//  QTest
//
//  Created by TM Mac 01 on 10/13/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func goForward() {
        self.performSegue(withIdentifier: String(describing: WelcomeViewController.self), sender: nil)
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
