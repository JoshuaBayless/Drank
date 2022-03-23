//
//  CocktailData.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import Foundation



struct CocktailModel {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let name: String
    let instructions: String
    let ingredient1: String
    let ingredient2: String
    let measure1: String
    let meatsure2: String
}
