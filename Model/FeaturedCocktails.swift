//
//  FaturedCocktails.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit


struct FeaturedCocktails {
    let name: String
    let image: UIImage
}

let cocktails: [FeaturedCocktails] = [
    FeaturedCocktails(name: "Margarita", image: #imageLiteral(resourceName: "Margarita")),
    FeaturedCocktails(name: "Vesper", image: #imageLiteral(resourceName: "Vesper-1")),
    FeaturedCocktails(name: "Whiskey Sour", image: #imageLiteral(resourceName: "WhiskeySour.jpeg")),
    FeaturedCocktails(name: "Mai Tai", image: #imageLiteral(resourceName: "mai-tai.jpeg")),
    FeaturedCocktails(name: "Paloma", image: #imageLiteral(resourceName: "Paloma-1")),
    FeaturedCocktails(name: "Negroni", image: #imageLiteral(resourceName: "negroni.webp")),
    FeaturedCocktails(name: "Gin and Tonic", image: #imageLiteral(resourceName: "G&T")),
    FeaturedCocktails(name: "moscow Mule", image: #imageLiteral(resourceName: "moscowmule.jpeg")),
    FeaturedCocktails(name: "Manhattan", image: #imageLiteral(resourceName: "manhattan.jpeg")),
]

