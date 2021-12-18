//
//  FUser.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/17/21.
//

import Foundation
import Firebase
import UIKit

// check if one user is the same as the other
class FUser: Equatable {
    static func == (lhs: FUser, rhs: FUser) -> Bool {
        lhs.objectId == rhs.objectId
    }
    
    let objectId: String
    let registeredDate = Date()
    var email: String
    var username: String
//    TODO: Add if want
    var avatarLink: String
    var about: String
//    avoid duplicate
    var avatar: UIImage?
    var likedIdArray: [String]?
    var imageLinks: [String]?
//    For user notification
    var pushId: String?
    
    var country: String
    var city: String
//    TODO: Add if want
    var typeTarget: String
    var ageTarget: String
    var sizeTarget: String
    var genderTarget: String
    // TODO: can add breed
    
    var userDictionary: NSDictionary {
        return NSDictionary(objects: [
            self.objectId,
            self.email,
            self.username,
            self.avatarLink,
            self.about,
            self.likedIdArray ?? [],
            self.imageLinks ?? [],
            self.registeredDate,
            self.pushId ?? "",
            self.country,
            self.city,
            self.typeTarget,
            self.ageTarget,
            self.sizeTarget,
            self.genderTarget
        ], forKeys: [
            kOBJECTID as NSCopying,
            kEMAIL as NSCopying,
            kUSERNAME as NSCopying,
            kAVATARLINK as NSCopying,
            kABOUT as NSCopying,
            kLIKEDARRAY as NSCopying,
            kIMAGELINKS as NSCopying,
            kREGISTRATIONDATE as NSCopying,
            kPUSHID as NSCopying,
            kCOUNTRY as NSCopying,
            kCITY as NSCopying,
            kTYPETARGET as NSCopying,
            kAGETARGET as NSCopying,
            kSIZETARGET as NSCopying,
            kGENDERTARGET as NSCopying
        ])
    }
    
    // Initializer
    init(_objectId: String, _email: String, _username: String, _avatarLink: String = "") {
        objectId = _objectId
        email = _email
        username = _username
        about = ""
        city = ""
        country = ""
        city = ""
        imageLinks = []
        avatarLink = _avatarLink
        pushId = ""
        
        typeTarget = ""
        ageTarget = ""
        sizeTarget = ""
        genderTarget = ""
        likedIdArray = []
        
    }
    
    init(_dictionary: NSDictionary) {
        objectId = _dictionary[kOBJECTID] as? String ?? ""
        email = _dictionary[kEMAIL] as? String ?? ""
        username = _dictionary[kUSERNAME] as? String ?? ""
        about = _dictionary[kABOUT] as? String ?? ""
        city = _dictionary[kCITY] as? String ?? ""
        country = _dictionary[kCOUNTRY] as? String ?? ""
        city = _dictionary[kCITY] as? String ?? ""
        imageLinks = _dictionary[kIMAGELINKS] as? [String]
        avatarLink = _dictionary[kAVATARLINK] as? String ?? ""
        pushId = _dictionary[kPUSHID] as? String ?? ""
        
        typeTarget = _dictionary[kTYPETARGET] as? String ?? ""
        ageTarget = _dictionary[kAGETARGET] as? String ?? ""
        sizeTarget = _dictionary[kSIZETARGET] as? String ?? ""
        genderTarget = _dictionary[kGENDERTARGET] as? String ?? ""
        likedIdArray = _dictionary[kLIKEDARRAY] as? [String]
        
        
        
    }
    
    // MARK: Returning current user
    class func currentId() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> FUser? {
        if Auth.auth().currentUser != nil {
            if let userDictionary = userDefaults.object(forKey: kCURRENTUSER) {
                return FUser(_dictionary: userDictionary as! NSDictionary)
            }
        }
        return nil
    }
    
    
    
    //MARK: - Save user funcs
    func saveUserLocally() {
        userDefaults.setValue(self.userDictionary as! [String : Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }
    
    func saveUserToFireStore() {
                
        FirebaseReference(.User).document(self.objectId).setData(self.userDictionary as! [String : Any]) { (error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    //MARK: - Update User funcs
    
    func updateCurrentUserInFireStore(withValues: [String : Any], completion: @escaping (_ error: Error?) -> Void) {
        
        if let dictionary = userDefaults.object(forKey: kCURRENTUSER) {
            
            let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
            userObject.setValuesForKeys(withValues)
            
            FirebaseReference(.User).document(FUser.currentId()).updateData(withValues) {
                error in
                
                completion(error)
                if error == nil {
                    FUser(_dictionary: userObject).saveUserLocally()
                }
            }
        }
    }
    
    
    //MARK: - LogOut user
    
    class func logOutCurrentUser(completion: @escaping(_ error: Error?) ->Void) {
        
        do {
            try Auth.auth().signOut()
            
            userDefaults.removeObject(forKey: kCURRENTUSER)
            userDefaults.synchronize()
            completion(nil)

        } catch let error as NSError {
            completion(error)
        }
    }
    
}
