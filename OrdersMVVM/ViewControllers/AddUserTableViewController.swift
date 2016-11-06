//
//  AddUserTableViewController.swift
//  OrdersMVVM
//
//  Created by JoLi on 2016-08-27.
//  Copyright © 2016 JoLi. All rights reserved.
//

import UIKit

class AddUserTableViewController: UITableViewController, AlertPresentable {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var viewModel = AddUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    @IBAction func addUserButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
        
        let userName = viewModel.validate(input: userNameTextField.text)
        let phoneNumber = viewModel.validate(input: phoneNumberTextField.text)
        
        if !userName.isValid {
            showAlert(withTitle: "Incorrect input.", message: "User Name must contain at least 5 characters.")
            
        } else if !phoneNumber.isValid {
            showAlert(withTitle: "Incorrect input.", message: "Phone Number must contain at least 5 numbers.")
            
        } else {
            ProgressOverlayView.show()
            viewModel.createUser(withName: userName.text, phone: phoneNumber.text, completion: { [weak self] (error) in
                ProgressOverlayView.dismiss()
                guard let strongSelf = self else { return }
                
                if let error = error {
                    strongSelf.showAlert(withTitle: "Error. Unable to upload new user.", message: error.localizedDescription)

                } else {
                    strongSelf.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
}



