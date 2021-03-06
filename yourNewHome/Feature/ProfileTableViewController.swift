//
//  ProfileTableViewController.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/17/21.
//

import UIKit
import Gallery
import ProgressHUD

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
    var uploadingAvatar = true
    
    var avatarImage: UIImage?
    var gallery: GalleryController!

    
    //MARK: ViewLifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // always be light mode
        overrideUserInterfaceStyle = .light
//        Setup
        setupBackgrounds();
        
        setupPickerView()
        setupBackgrounds()
        
        if (FUser.currentUser() != nil) {
            loadUserData();
            updateEditingMode();
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }


//    Mark - IBActions
//    TODO: add buttons for the switch or delete them
    @IBAction func settingsButtonPressed(_ sender: Any) {
        showEditOptions()
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        showPictureOptions()
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        editingMode.toggle()
        updateEditingMode()
        
        editingMode ? showKeyboard() : hideKeyboard()
        showSaveButton()
        
    }
    
    @objc func editUserData() {
        let user = FUser.currentUser()!
        
        user.about = aboutMeTextView.text
        user.city = cityTextField.text ?? ""
        user.country = countryTextField.text ?? ""
        
        if avatarImage != nil {
            // upload new avatar
            // save user
            uploadAvatar(avatarImage!) { (avatarLink) in
                
                user.avatarLink = avatarLink ?? ""
                user.avatar = self.avatarImage
                
                self.saveUserData(user: user)
                self.loadUserData()
            }
            
        } else {
            // save
            saveUserData(user: user)
            loadUserData()
        }
        
        // disable editing mode
        editingMode = false
        updateEditingMode()
        showSaveButton()

    }
    
    private func saveUserData(user: FUser) {
        user.saveUserLocally()
        user.saveUserToFireStore()
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
        
        navigationItem.rightBarButtonItem = editingMode ? saveButton : nil
    }
    
    // MARK: picker view
    private func setupPickerView() {

        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor().primary()
        toolBar.sizeToFit()

        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        doneButton.tintColor = .black
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true

    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    
    
//    MARK: load userdata
    // TODO: add default value for those switch
    private func loadUserData() {
        let currentUser = FUser.currentUser()!
        FileStorage.downloadImage(imageUrl: currentUser.avatarLink) { (image) in
            
        }
        usernameLabel.text = currentUser.username
        cityCountryLabel.text = currentUser.country + ", " + currentUser.city
        aboutMeTextView.text = currentUser.about != "" ? currentUser.about : "A little bit about me..."
        cityTextField.text = currentUser.city
        countryTextField.text = currentUser.country
        // TODO: set avatar picture
        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.image = currentUser.avatar?.circleMasked
    }
    
    
//    MARK: Editing mode:
    // allow user to edit
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

    //MARK: alert controller
    private func showPictureOptions() {
        let alertController = UIAlertController(title: "Upload Picture", message: "Change your picture or upload more photo", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Change Portofolio", style: .default, handler: { (alert) in
            self.showGallery(forAvatar: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // show edit
    private func showEditOptions() {
        let alertController = UIAlertController(title: "Edit Account", message: "You are about to edit your information.", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Change Email", style: .default, handler: { (alert) in
            print("change avatar")
        }))
        alertController.addAction(UIAlertAction(title: "Change Name", style: .default, handler: { (alert) in
            print("upload pic")
        }))
        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {
            (alert) in self.logOutUser()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: logout
    
    private func logOutUser() {
        
        FUser.logOutCurrentUser { (error) in
            
            if error == nil {
                
                let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
                
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
                
            } else {
                ProgressHUD.showError(error!.localizedDescription)
            }
        }
        
    }
    
    // MARK: Upload images
    private func uploadAvatar(_ image: UIImage, completion: @escaping (_ avatarLink: String?)-> Void) {
        
        ProgressHUD.show()
        
        let fileDirectory = "Avatars/_" + FUser.currentId() + ".jpg"
        
        FileStorage.uploadImage(image, directory: fileDirectory) { (avatarLink) in
            
            ProgressHUD.dismiss()
            FileStorage.saveImageLocally(imageData: image.jpegData(compressionQuality: 0.8)! as NSData, fileName: FUser.currentId())
            completion(avatarLink)
        }
        
    }

    
    
    
    // MARK: Gallery
    private func showGallery(forAvatar: Bool) {
     
        uploadingAvatar = forAvatar
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 1
        Config.initialTab = .imageTab
        
        self.present(gallery, animated: true, completion: nil)
        
    }

}

//MARK: extensions gallery


extension ProfileTableViewController: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
//        user did chose an img
        if (images.count > 0) {
            if (uploadingAvatar) {
                images.first!.resolve { icon in
                    if icon != nil {
                        self.editingMode = true
                        self.showSaveButton()
                        self.avatarImageView.image = icon
                        self.avatarImage = icon
                    }
                }
            } else {
                print("have multiple images")
            }
        }
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    
}

