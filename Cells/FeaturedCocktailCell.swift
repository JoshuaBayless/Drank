//
//  FeaturedCocktailCell.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit

class FeaturedCocktailCell: UICollectionViewCell {
    
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailName: UILabel!
 
    
    func setup(with cocktail: FeaturedCocktails){
        cocktailImage.image = cocktail.image
        cocktailName.text = cocktail.name
    }
}
