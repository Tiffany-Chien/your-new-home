//
//  LoginViewController.swift
//  
//
//  Created by John Hong on 2021-11-26.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //TODO: Link signin
    @IBAction func onSignIn(_ sender: Any) {
        print("sign in clicked")
//      validate username
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            print("error, missing field data")
            return
        }
        // Get auth instance
        
        // attempt sign in
        
        // if failure, present alert to create account
        
        // if user continues, create account
                
        // check sign in on app launch
        // allow user to sign out with button
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password,  completion: { [weak self] result, error in guard let strongSelf = self else{
            return
        }
            guard error == nil else {
//           TODO: show message that account doesnt exist
            print("account doesn't exist")
                strongSelf.showCreateAccount(email: email, password: password)
            return
        }
            self?.performSegue(withIdentifier: "loginSegue", sender: nil)
        })
        print("You have signed in");
    }
    
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in guard let strongSelf = self else{
                return
            }
                guard error == nil else{
                    print("Account creation failed")
                    
                    let failedAlert = UIAlertController(title: "Failed", message: "Account creation failed. Please try again", preferredStyle: .alert)
                    failedAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in}))
                    self?.present(failedAlert, animated: true)
                    return
                }
                
                print("You have signed in")
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        print("sign up clicked")
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
