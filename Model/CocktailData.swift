//
//  CocktailData.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit


struct CocktailData: Decodable {
    let drinks:[Drinks]
}

struct Drinks: Decodable {
    let strDrink: String
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strImageSource: String?
}
