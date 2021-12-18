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
                
            } else {
                // first login
                
            }
        }
    }
    
    
    
    
}
