//
//  CardViewController.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/18/21.
//

import UIKit
import Shuffle_iOS
import Firebase

class CardViewController: UIViewController {
    
    //MARK: Testing data
    private let cardStack = SwipeCardStack()
    private var initialCardModels: [UserCardModel] = []
    
    
    //MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let user = FUser.currentUser()
        let cardModel = UserCardModel(name: "Cat", age: "Baby", breed: "American", image: UIImage(named: "avatar"))
        initialCardModels.append(cardModel)
        layoutCardStackView()
    }
    
    //MARK: Layoyt
    private func layoutCardStackView() {
        cardStack.delegate = self
        cardStack.dataSource = self
        
        view.addSubview(cardStack)
        
        cardStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
    }

    
}


extension CardViewController: SwipeCardStackDelegate, SwipeCardStackDataSource {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = UserCard()
        card.footerHeight = 80
        // card can swipe left and right
        card.swipeDirections = [.left, .right]
        // set overlay for card
        for direction in card.swipeDirections {
            card.setOverlay(UserCardOverlay(direction: direction), forDirection: direction)
        }
        // configure card
        card.configure(withModel: initialCardModels[index])
        
        return card
    }
    
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return initialCardModels.count
    }
    
    
}
