//
//  FCollectionReference.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/17/21.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
