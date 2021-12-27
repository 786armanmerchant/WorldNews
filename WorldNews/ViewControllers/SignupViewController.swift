//
//  SignupViewController.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//
import Foundation
import UIKit
import MaterialTextField
import Firebase

class SignupViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextfield: MFTextField!
    @IBOutlet weak var lastNameTextfield: MFTextField!
    @IBOutlet weak var emailTextfield: MFTextField!
    @IBOutlet weak var passwordTextfield: MFTextField!
    @IBOutlet weak var confirmPasswordTextfield: MFTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        
        
            var isValidated = true
            if !(CommonUtils.validateTextfield(item: emailTextfield.getText(), regEx: RegEx.email)){
                isValidated = false
                emailTextfield.showError("Invalid email", true, .red)
            }else{
                emailTextfield.removeError()
            }
            if !(CommonUtils.validateTextfield(item: passwordTextfield.getText(), regEx: RegEx.password)){
                isValidated = false
                passwordTextfield.showError("Invalid password", true, .red)
            }else{
                passwordTextfield.removeError()
            }
            if !(CommonUtils.validateTextfield(item: firstNameTextfield.getText(), regEx: RegEx.name)){
                isValidated = false
                firstNameTextfield.showError("Invalid first name", true, .red)
            }else{
                firstNameTextfield.removeError()
            }
            if !(CommonUtils.validateTextfield(item: lastNameTextfield.getText(), regEx: RegEx.name)){
                isValidated = false
                lastNameTextfield.showError("Invalid last name", true, .red)
            }else{
                lastNameTextfield.removeError()
            }
            if !(passwordTextfield.getText() == confirmPasswordTextfield.getText()){
                isValidated = false
                confirmPasswordTextfield.showError("password does not match", true, .red)
            }else{
                confirmPasswordTextfield.removeError()
            }
            if isValidated {
               registerUser()
            }
       
       
    }
    
    
    fileprivate func registerUser(){
        
        Auth.auth().createUser(withEmail: emailTextfield.getText(), password: passwordTextfield.getText()) { authResult, error in
          // ...
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                               
                 alertController.addAction(defaultAction)
                 self.present(alertController, animated: true, completion: nil)
            }
             
            else {
                //Nagivate to homescreen
              
                self.navigateToHomeScreen()
                
            }
            
            
        }
    
    }
    
    
    fileprivate func navigateToHomeScreen(){
        guard let homeVC = CommonUtils.getViewController(id: "HomeTabViewController")   as? HomeTabViewController else {
            return
        }
        navigationController?.pushViewController(homeVC, animated: true)
    }
}



