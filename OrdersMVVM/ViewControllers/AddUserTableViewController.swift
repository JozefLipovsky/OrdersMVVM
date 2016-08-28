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
    
    var viewModel = AddUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    // MARK: - IBAction
    
    @IBAction func addUserButtonPressed(sender: UIButton) {
        let userName = viewModel.validate(input: userNameTextField.text)
        let phoneNumber = viewModel.validate(input: phoneNumberTextField.text)
        
        if !userName.isValid || !phoneNumber.isValid {
            // TODO: Alert...
            print("Invalid input")
        } else {
            ProgressOverlayView.show()
            //viewModel.createUser(withName: userName.text, phone: phoneNumber.text)
        }
        
    }
    
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        ProgressOverlayView.dismiss()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}




