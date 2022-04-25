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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
    
}



