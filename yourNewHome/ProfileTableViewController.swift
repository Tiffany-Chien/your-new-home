//
//  ProfileTableViewController.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/17/21.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
//    MARK: IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var profileCellBackgroundView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var cityCountryLabel: UILabel!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var aboutMeView: UIView!
    
    
//    MARK: Vars
    var editingMode = false
    
    
    //MARK: ViewLifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // always be light mode
        overrideUserInterfaceStyle = .light
//        Setup
        setupBackgrounds();
        updateEditingMode();
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }


//    Mark - IBActions
//    TODO: add buttons for the switch or delete them
    @IBAction func settingButtonPressed(_ sender: Any) {
    }
    
    @IBAction func camerButtonPressed(_ sender: Any) {
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        // switch it on or off
        editingMode.toggle()
        updateEditingMode()
        editingMode ? showKeyboard() : hideKeyboard()
        // todo fix this
        showSaveButton()
        if (editingMode) {
//            if the show save button not fix
//            We temporariliy want to save it when pressed
        }
        
    }
    
    @objc func editUserData() {
        
    }
    
    @IBAction func typeSwitchPressed(_ sender: Any) {
    }
    
    @IBAction func genderSwitchPressed(_ sender: Any) {
    }
    
    @IBAction func ageSwitchPressed(_ sender: Any) {
    }
    
    @IBAction func sizeSwitchpressed(_ sender: Any) {
    }
    
//    Setup
    private func setupBackgrounds() {
        profileCellBackgroundView.clipsToBounds = true
        profileCellBackgroundView.layer.cornerRadius = 100
        profileCellBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        // about me text view
        aboutMeView.layer.cornerRadius = 10
        
    }
    
    private func showSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editUserData))
//        TODO: add a nav bar
        navigationItem.rightBarButtonItem = editingMode ? saveButton : nil
    }
    
    
//    Editing mode: allow user to edit
    private func updateEditingMode() {
        aboutMeTextView.isUserInteractionEnabled = editingMode
        cityTextField.isUserInteractionEnabled = editingMode
        countryTextField.isUserInteractionEnabled = editingMode
        
    }
    
    
    //MARK: helpers
    private func showKeyboard() {
//        we want to jump to the about me section
        self.aboutMeTextView.becomeFirstResponder()
    }
    
    private func hideKeyboard() {
        self.view.endEditing(false)
    }

    

}
