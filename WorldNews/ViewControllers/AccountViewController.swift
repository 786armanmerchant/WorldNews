//
//  AccountViewController.swift
//  WorldNews
//
//  Created by Arman Merchant on 06/12/21.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func signOutClicked(_ sender: Any) {
        
        
        do {
            
          try Auth.auth().signOut()
          
           navigateToSignIn()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    func navigateToSignIn(){
        guard let signinVC = CommonUtils.getViewController(id: "WelcomeViewController")   as? WelcomeViewController else {
            return
        }
       let nav = UINavigationController(rootViewController:  signinVC)
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.prefersLargeTitles = true
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    

     
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
