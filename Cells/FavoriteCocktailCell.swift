//
//  FavoriteCocktailCell.swift
//  Drank
//
//  Created by Josh  Bayless on 4/4/22.
//

import UIKit


class FavoriteCocktailCell: UICollectionViewCell {
    

    @IBOutlet weak var favoriteCocktailImage: UIImageView!
    @IBOutlet weak var favoriteCocktailName: UILabel!
    
    func setup(with cocktail: Favorites){
        
            favoriteCocktailImage.image = #imageLiteral(resourceName: "Margarita")
        
        
        favoriteCocktailName.text = cocktail.name
    }
}
