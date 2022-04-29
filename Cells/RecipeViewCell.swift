//
//  RecipeViewCell.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit
import Kingfisher

class RecipeViewCell: UICollectionViewCell {
    
    var viewController = ViewController()
    


    @IBOutlet weak var cocktailName: UILabel!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var ingredient1: UILabel!
    @IBOutlet weak var ingredient2: UILabel!
    @IBOutlet weak var ingredient3: UILabel!
    @IBOutlet weak var ingredient4: UILabel!
    @IBOutlet weak var ingredient5: UILabel!
    @IBOutlet weak var measurement1: UILabel!
    @IBOutlet weak var measurement2: UILabel!
    @IBOutlet weak var measurement3: UILabel!
    @IBOutlet weak var measurement4: UILabel!
    @IBOutlet weak var measurement5: UILabel!
    @IBOutlet weak var cocktailImage: UIImageView!

    @IBAction func addToFavorites(_ sender: Any) {
        print("Button Pressed")
        if let cocktail = cocktailName.text {
            let newFavorite = Favorites(context: viewController.context)
            newFavorite.name = cocktail
            newFavorite.image = nil
            do {
                try viewController.context.save()
                viewController.fetchFavorites()
            } catch {
            
            }
        }
        print(favoritesList)
    }
    
    
    func setup(with drink: Drinks){
        cocktailName.text = drink.strDrink
        instructions.text = drink.strInstructions
        ingredient1.text = drink.strIngredient1 ?? ""
        ingredient2.text = drink.strIngredient2 ?? ""
        ingredient3.text = drink.strIngredient3 ?? ""
        ingredient4.text = drink.strIngredient4 ?? ""
        ingredient5.text = drink.strIngredient5 ?? ""
        measurement1.text = drink.strMeasure1 ?? ""
        measurement2.text = drink.strMeasure2 ?? ""
        measurement3.text = drink.strMeasure3 ?? ""
        measurement4.text = drink.strMeasure4 ?? ""
        measurement5.text = drink.strMeasure5 ?? ""
        
//            if let urlString = drink.strImageSource {
//                print(urlString)
//                let url = URL(string: "https://www.thecocktaildb.com/images/media/drink/il9e0r1582478841.jpg")
//                self.cocktailImage.kf.setImage(with: url)
//            } else {
//                return
//            }
    }
}
