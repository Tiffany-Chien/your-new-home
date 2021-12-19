//
//  CardViewController.swift
//  yourNewHome
//
//  Created by Tiffany Chien on 12/18/21.
//

import UIKit
import Shuffle_iOS
import Firebase
import FirebaseCore
import FirebaseDatabase

class CardViewController: UIViewController {
    
    //MARK: Testing data
    private let cardStack = SwipeCardStack()
    private var initialCardModels: [UserCardModel] = []

    

    
    //MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let user = FUser.currentUser()
//        let cardModel = UserCardModel(name: "Cat", age: "Baby", breed: "American", image: UIImage(named: "avatar"))
//        initialCardModels.append(cardModel)
        // hard code data no internet ;(
        loadDataHelper(petName: "Coco Puff", petAge: "Baby", petBreed: "Dilute Tortoiseshell", petImage: "pet01")
        loadDataHelper(petName: "Kershaw", petAge: "Adult", petBreed: "Terrier", petImage: "pet02")
        loadDataHelper(petName: "Trevor", petAge: "Young", petBreed: "Landrador Retriever", petImage: "pet03")
        loadDataHelper(petName: "Isabella", petAge: "Adult", petBreed: "Landrador Retriever", petImage: "pet04")
        loadDataHelper(petName: "Erin", petAge: "Young", petBreed: "American Shorthair", petImage: "pet05")
        loadDataHelper(petName: "Hudson", petAge: "Adult", petBreed: "Alaskan Malamute", petImage: "pet06")
        loadDataHelper(petName: "Casey", petAge: "Baby", petBreed: "Tabby", petImage: "pet07")

        loadDataHelper(petName: "Tandy", petAge: "Baby", petBreed: "Australian Cattle Dog", petImage: "pet08")
        loadDataHelper(petName: "Mooshie", petAge: "Young", petBreed: "Australian Cattle Dog", petImage: "pet09")
        loadDataHelper(petName: "Opie", petAge: "Young", petBreed: "Pit Bull Terrier", petImage: "pet10")
        loadDataHelper(petName: "Tami", petAge: "Baby", petBreed: "Australian Cattle Dog", petImage: "pet11")
        loadDataHelper(petName: "Trina", petAge: "Baby", petBreed: "Australian Cattle Dog", petImage: "pet12")
        
        layoutCardStackView()
    }
    
    private func loadDataHelper(petName: String, petAge: String, petBreed: String, petImage: String) {
        let card = UserCardModel(name: petName, age: petAge, breed: petBreed, image: UIImage(named: petImage))
        initialCardModels.append(card)
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
