//
//  FUser.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/17/21.
//

import Foundation
import Firebase

// check if one user is the same as the other
class FUser: Equatable {
    static func == (lhs: FUser, rhs: FUser) -> Bool {
        lhs.objectId == rhs.objectId
    }
    
    let objectId: String = ""
    
    
    // TODO: add username text field username: String as params
    class func registerUserWith(email: String, password: String, name: String, completion: @escaping (_ error: Error?)-> Void) {
        print("Register user")
    }
}
