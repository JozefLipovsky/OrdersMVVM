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
        setupGestureRecognizer()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        userNameTextField.becomeFirstResponder()
    }
    
    
    // MARK: - Helpers
    
    func setupGestureRecognizer () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - IBAction
    
    @IBAction func addUserButtonPressed(sender: UIButton) {
        dismissKeyboard()
        
        let userName = viewModel.validate(input: userNameTextField.text)
        let phoneNumber = viewModel.validate(input: phoneNumberTextField.text)
        
        if !userName.isValid {
            let alert = UIAlertController(title: "Incorrect input.", message: "User Name must contain at least 5 characters.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.userNameTextField.becomeFirstResponder()
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else if !phoneNumber.isValid {
            let alert = UIAlertController(title: "Incorrect input.", message: "Phone Number must contain at least 5 numbers.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.phoneNumberTextField.becomeFirstResponder()
            }))
            self.presentViewController(alert, animated: true, completion: nil)

        } else {
            ProgressOverlayView.show()
            viewModel.createUser(withName: userName.text, phone: phoneNumber.text, completion: { [weak self] (error) in
                ProgressOverlayView.dismiss()
                guard let strongSelf = self else { return }
                
                if let error = error {
                    let alert = UIAlertController(title: "Error.", message: error.localizedDescription, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    strongSelf.presentViewController(alert, animated: true, completion: nil)
                } else {
                    strongSelf.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
    }
    
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        dismissKeyboard()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}



