//
//  AddUserTableViewController.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-27.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit

class AddUserTableViewController: UITableViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - IBAction
    
    @IBAction func addUserButtonPressed(sender: UIButton) {
        
    }
    
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
