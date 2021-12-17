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
    
    
    //MARK: ViewLifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Setup
        setupBackgrounds();
    }


//    Mark - IBActions
    @IBAction func settingButtonPressed(_ sender: Any) {
    }
    
    @IBAction func camerButtonPressed(_ sender: Any) {
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    

}
