//
//  QuestionViewController.swift
//  QTest
//
//  Created by Shah Newaz Hossain on 10/15/16.
//  Copyright © 2016 Shah Newaz Hossain. All rights reserved.
//

import UIKit
import TSMessages

class QuestionViewController: UIViewController {

    private var index = 0
    private var currentQues: Question?
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var quesLbl: UILabel!
    @IBOutlet weak var trueBtn: UIButton!
    @IBOutlet weak var falseBtn: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome to Qtest"
        // Do any additional setup after loading the view.
//        self.sideMenuController()?.sideMenu?.delegate = self
//        let nav = self.navigationController as! ENSideMenuNavigationController
//        nav.sideMenu = ENSideMenu(sourceView: self.view, menuViewController: MenuItemsViewController(), menuPosition:.right)
//        view.bringSubview(toFront: nav.navigationBar)

//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleSideMenu(sender:)))
        nextBtn.backgroundColor = DisableAppearanceColor
        progressBar.progress = 0
        requestForQuestion()
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
    
    func requestForQuestion() {
        let taken = 1 + (NumberFormatter().number(from: UserObject.sharedUser.testTakenCount)?.intValue)!
        var param: [String: Any] = [
            "user_id": UserObject.sharedUser.userId,
            "off_set": index as NSNumber,
            "qtest_try": NSNumber(value: taken)
        ]
        if currentQues == nil {
            param["question_id"] = ""
            param["question_answer"] = 0
        }
        else {
            param["question_id"] = currentQues?.questionId
            param["question_answer"] = NSNumber(value: (currentQues?.answer)!)
        }
        APIManager.sharedInstance.executePostRequest(urlString: "questionlist", parameters: param, Success: { (response) in
            guard response.value(forKey: "results") == nil else {
                self.currentQues = Question(response.value(forKey: "results") as! NSDictionary)
                self.refreshQuestion()
                return
            }
        
//            self.navigationController?.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController"))!, animated: true)
            self.performSegue(withIdentifier: "ResultViewController", sender: nil)
            
        }) { (error) in
            TSMessage.showNotification(withTitle: error, type: .error)
        }
    }
    
    func refreshQuestion() {
        quesLbl.text = currentQues?.questionText
        falseBtn.isSelected = false
        trueBtn.isSelected = false
        index += 1
        nextBtn.backgroundColor = DisableAppearanceColor
        nextBtn.isEnabled = false
        let result = Float(index) / Float(90)
        progressBar.progress = result
    }
    
    @IBAction func tapAnswer(_ sender: UIButton) {
        if sender == trueBtn {
            trueBtn.isSelected = true
            falseBtn.isSelected = false
            currentQues?.answer = 1
        }
        else {
            trueBtn.isSelected = false
            falseBtn.isSelected = true
            currentQues?.answer = 0
        }
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = AppAppearanceColor
    }
    
    @IBAction func nextAct(_ sender: UIButton) {
        index = 90
        requestForQuestion()
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
