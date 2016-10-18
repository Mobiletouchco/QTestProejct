//
//  MenuItemsViewController.swift
//  QTest
//
//  Created by Shah Newaz Hossain on 10/15/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit

extension Bool {
    init<T : Integer>(_ integer: T) {
        if integer == 0 {
            self.init(false)
        } else {
            self.init(true)
        }
    }
}
class MenuItemsViewController: UITableViewController {

    private var menuList = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        menuList = ["الشاشة الرئيسية", "إعادة اختبار", "خروج"]
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menuList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MenuCell")
        }
        cell!.textLabel?.text = menuList[indexPath.row] as? String
        
        return cell!
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        UserObject.sharedUser.container?.toggleRightSideMenuCompletion({ 
            switch indexPath.row {
            case 0,1  :
                UserObject.sharedUser.willGoForTest = Bool(indexPath.row)
                self.navigationController?.isNavigationBarHidden = true
                _ = self.navigationController?.popToRootViewController(animated: false)
                break
//            case 1  :
//                if UserObject.sharedUser.container?.centerViewController is QuestionViewController {
//                    // touch.view is of type UIPickerView
//                }
//                else {
//                    UserObject.sharedUser.container?.centerViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: QuestionViewController.self))
//                }
//                break
            case 2  :
                USERDEFAULTS.set(false, forKey: kStringLoginKey)
                USERDEFAULTS.synchronize()
                self.navigationController?.isNavigationBarHidden = true
                _ = self.navigationController?.popToRootViewController(animated: false)
                break
            default :
                break
            }
        })
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
