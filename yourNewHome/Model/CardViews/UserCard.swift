//
//  UserCard.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/18/21.
//

import Foundation
import Shuffle_iOS
import Shuffle_iOS

class UserCard: SwipeCard {

    func configure(withModel model: UserCardModel) {
        content = UserCardContentView(withImage: model.image)
        footer = UserCardFooterView(withTitle: "\(model.name), \(model.age)", subTitle: model.breed)
    }
    
}
