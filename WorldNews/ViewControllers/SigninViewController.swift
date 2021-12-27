//
//  SigninViewController.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import UIKit
import Firebase
import MaterialTextField

class SigninViewController: UIViewController {
    

    @IBOutlet weak var emailTextfield: MFTextField!
    
    @IBOutlet weak var passwordTextfield: MFTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinButtonClicked(_ sender: Any) {
        
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
        if isValidated {
            signingInUser()
        }
    }
    
    
    // MARK: - Signing In User

    fileprivate func signingInUser() {
        
        Auth.auth().signIn(withEmail: emailTextfield.getText(), password: passwordTextfield.getText()) {  authResult, error in

            if error != nil {

                 let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                
                  alertController.addAction(defaultAction)
                  self.present(alertController, animated: true, completion: nil)
                     
            }else {
           
               // Navigate user to HomeScreen
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
    // MARK: - Navigation

}
