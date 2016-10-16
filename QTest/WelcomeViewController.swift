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
    private var container: MFSideMenuContainerViewController? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        fullNameLbl.text = UserObject.sharedUser.firstName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBack() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    func goForward() {
        container = MFSideMenuContainerViewController.container(withCenter: storyboard?.instantiateViewController(withIdentifier: "QuestionViewController"), leftMenuViewController: nil, rightMenuViewController: MenuItemsViewController())
        // disable panning on the side menus, only allow panning on the center view controller:
//        menuContainerViewController.panMode = MFSideMenuPanModeCenterViewController
        // disable all panning
        container?.panMode = MFSideMenuPanModeNone
        container?.navigationItem.hidesBackButton = true
        container?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleSideMenu(sender:)))
        self.navigationController?.pushViewController(container!, animated: true)
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
        container?.toggleRightSideMenuCompletion({ 
            
        })
    }
}
