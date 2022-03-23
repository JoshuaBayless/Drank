//
//  RecipeViewController.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit


class RecipeViewController: UICollectionViewController {
    
    var drinks = [Drinks]()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeViewCell", for: indexPath) as! RecipeViewCell
            cell.setup(with: drinks[indexPath.row])
            return cell
        }
}
    


