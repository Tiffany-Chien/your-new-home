//
//  FirebaseListener.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/18/21.
//

import Foundation
import Firebase

//Firebase checking, updating
class FirebaseListener {
    
    static let shared = FirebaseListener()
    
//    Singleton
    private init() {}
    
//    FUser
    func downloadCurrentUserFromFirebase(userId: String, email: String) {
        FirebaseReference(.User).document(userId).getDocument { snapshot, error in
            guard let snapshot = snapshot else {return}
            if snapshot.exists {
                // user logged in before
                let user = FUser(_dictionary: snapshot.data() as! NSDictionary)
                // save it locally
                user.saveUserLocally()
            } else {
                // first login
                if let user = userDefaults.object(forKey: kCURRENTUSER) {
                    FUser(_dictionary: user as! NSDictionary).saveUserToFireStore()
                    // save it to firebase
                }
                
            }
        }
    }
    
    
    
    
}
