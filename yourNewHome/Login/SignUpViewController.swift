//
//  SignUpViewController.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/3/21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else{ print ("Email is empty"); return}
        guard let password = passTextField.text, !password.isEmpty else {print("Password is empty"); return}
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in guard error == nil else {
            //           TODO: show message that account doesnt exist
            print(error?.localizedDescription)
            let failedAlert = UIAlertController(title: "Failed", message: error?.localizedDescription, preferredStyle: .alert)
            failedAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in}))
            self.present(failedAlert, animated: true)
            return
        }
            print("You have signed up")
//            self.performSegue(withIdentifier: "successSignUp", sender: nil)
            if (result?.user != nil) {
                let user = FUser(_objectId: result!.user.uid, _email: email, _username: self.nameTextField.text!)
                user.saveUserLocally()
            }
            self.goToApp()

        })
        
    }
    
    
    
    
    // MARK: - Navigation


    private func goToApp() {
        
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MainView") as! UITabBarController
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
        
    }
}
