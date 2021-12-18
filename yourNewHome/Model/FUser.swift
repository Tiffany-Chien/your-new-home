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
        
        typeTarget = ""
        ageTarget = ""
        sizeTarget = ""
        genderTarget = ""
        likedIdArray = []
        
    }
    
    
//    // TODO: add username text field username: String as params
//    class func registerUserWith(email: String, name: String, completion: @escaping (_ error: Error?)-> Void) {
//
//    }
    
    func saveUserLocally() {
        userDefaults.setValue(self.userDictionary as! [String : Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }
}
