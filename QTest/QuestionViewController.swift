//
//  QuestionViewController.swift
//  QTest
//
//  Created by Shah Newaz Hossain on 10/15/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit


class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome to Qtest"
        // Do any additional setup after loading the view.
//        self.sideMenuController()?.sideMenu?.delegate = self
//        let nav = self.navigationController as! ENSideMenuNavigationController
//        nav.sideMenu = ENSideMenu(sourceView: self.view, menuViewController: MenuItemsViewController(), menuPosition:.right)
//        view.bringSubview(toFront: nav.navigationBar)

//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleSideMenu(sender:)))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func toggleSideMenu(sender: UIBarButtonItem) {
//        toggleSideMenuView()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
}
