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
        if cocktail.image != nil {
            
        } else {
            favoriteCocktailImage.image = #imageLiteral(resourceName: "negroni")
        }
        
        favoriteCocktailName.text = cocktail.name
    }
}
