//
//  WelcomeViewController.swift
//  QTest
//
//  Created by TM Mac 01 on 10/13/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit
import MFSideMenu

class WelcomeViewController: UIViewController {

    @IBOutlet weak var fullNameLbl: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fullNameLbl.text = UserObject.sharedUser.firstName
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if UserObject.sharedUser.willGoForTest {
            goForward()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        USERDEFAULTS.set(false, forKey: kStringLoginKey)
        USERDEFAULTS.synchronize()
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    func goForward() {
        UserObject.sharedUser.createContainer(centreVC: (storyboard?.instantiateViewController(withIdentifier: String(describing: QuestionViewController.self)))!)
        UserObject.sharedUser.container?.title = "مرحبا لإختبار الميول"
        UserObject.sharedUser.container?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: self, action: #selector(toggleSideMenu(sender:)))//UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleSideMenu(sender:)))
        self.navigationController?.pushViewController(UserObject.sharedUser.container!, animated: !UserObject.sharedUser.willGoForTest)
        UserObject.sharedUser.willGoForTest = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func toggleSideMenu(sender: UIBarButtonItem) {
        UserObject.sharedUser.container?.toggleRightSideMenuCompletion({
            
        })
    }
}
