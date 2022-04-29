//
//  RecipeViewController.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit
import SwiftUI


class RecipeViewController: UIViewController {
    
    var drinks = [Drinks]()
    let refreshControl = UIRefreshControl()
    var jsonManager = JSONManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(getRandomCocktail(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Random Cocktail ...")
    }

    
}
//MARK: - Collection View Methods
extension RecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeViewCell", for: indexPath) as! RecipeViewCell
        cell.setup(with: drinks[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
                return screenSize
    }
    
    @objc func getRandomCocktail(_ sender: Any) {
        jsonManager.fetchRandomCocktailData() { result in
            switch result {
            case let .success(cocktailData):
                self.drinks = cocktailData.drinks
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
                }
        
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
}



