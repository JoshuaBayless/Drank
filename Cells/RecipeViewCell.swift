//
//  RecipeViewCell.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit

class RecipeViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var drinkTitle: UILabel!
    @IBOutlet weak var drinkDescription: UILabel!
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
    
    
    
    
    
    
    
    func setup(with drink: Drinks){
        drinkTitle.text = drink.strDrink
        drinkDescription.text = drink.strInstructions
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
    }
}
