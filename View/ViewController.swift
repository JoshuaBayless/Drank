//
//  ViewController.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var recipeViewController = RecipeViewController()
    var jsonManager = JSONManager()
    var drinks = [Drinks]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    


}
//MARK: - Collection View Functions

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCocktailCell", for: indexPath) as! FeaturedCocktailCell
        cell.setup(with: cocktails[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        jsonManager.fetchCocktailData(cocktails[indexPath.row].name) { result in
            switch result {
            case let .success(cocktailData):
                self.drinks = cocktailData.drinks
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toRecipes", sender: self)
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipes" {
            recipeViewController.drinks = drinks
        }
    }
    
    
}

