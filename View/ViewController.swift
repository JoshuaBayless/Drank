//
//  ViewController.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit
import Kingfisher


class ViewController: UIViewController {

    
    

    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var recipeViewController = RecipeViewController()
    var jsonManager = JSONManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        searchTextField.delegate = self
        
        fetchFavorites()
        collectionView.reloadData()
        
        setupLongGestureRecognizerOnCollection()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRecipes") {
            if let destination = segue.destination as? RecipeViewController {
                // pass the data over to the recipe view controller
                if let drinks = sender as? [Drinks] {
                    destination.drinks = drinks
                }
                
            }

            
        }
    }


}

//MARK: - UISearchBar Delegate
extension ViewController: UISearchBarDelegate {
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchedCocktail = searchTextField.text {
            jsonManager.fetchCocktailData(for: searchedCocktail) { result in
                switch result {
                case let .success(cocktailData):
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toRecipes", sender: cocktailData.drinks)
                    }

                case let .failure(error):
                    print(error)
                }
            }
        }
        searchTextField.text = ""
        
    }
}
    
    
//MARK: - Collection View Functions

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if favoritesList.count > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoritesList.count > 0 {
            return (section == 0) ? favoritesList.count : cocktails.count
        } else {
            return cocktails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if favoritesList.count > 0 && indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCocktailCell", for: indexPath) as! FavoriteCocktailCell
            cell.setup(with: favoritesList[indexPath.row])
            return cell
        } else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCocktailCell", for: indexPath) as! FeaturedCocktailCell
        cell.setup(with: cocktails[indexPath.row])
        return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
        flowlayout?.sectionInset.left = 18
        let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) + (flowlayout?.sectionInset.left ?? 0.0) + (flowlayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var searchedCocktail: String
        if favoritesList.count > 0 && indexPath.section == 0 {
            searchedCocktail = favoritesList[indexPath.row].name!
        } else {
            searchedCocktail = cocktails[indexPath.row].name
        }
        jsonManager.fetchCocktailData(for: searchedCocktail) { result in
            switch result {
            case let .success(cocktailData):
                
                //pass data to recipe view controller
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toRecipes", sender: cocktailData.drinks)
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    //MARK: - Section Headers
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            
            if favoritesList.count > 0 && indexPath.section == 0 {
                sectionHeader.sectionHeaderLabel.text = "Favorites"
            } else {
                sectionHeader.sectionHeaderLabel.text = "Featured"
            }
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    
    //MARK: - CoreData Methods
    
    func fetchFavorites() {
        do {
            favoritesList = try context.fetch(Favorites.fetchRequest())
            
        } catch {
            print(error)
        }
    }
    
    //MARK: - Managing Favorites (Delete/ Move)
    
    func showAlertButtonTapped(for indexPath: IndexPath) {

            // create the alert
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this recipe from your favorites?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { action in
            self.deleteRecipe(at: indexPath)
        }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    func deleteRecipe(at indexPath: IndexPath) {
        context.delete(favoritesList[indexPath.row])
        do {
            try context.save()
            
        } catch {
            print(error)
        }
    
        fetchFavorites()
        collectionView.reloadData()
    }
    
    
}
//MARK: - Gesture Recognition
extension ViewController: UIGestureRecognizerDelegate {
    
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: collectionView)

        if let indexPath = collectionView?.indexPathForItem(at: p) {
            if favoritesList.count > 0 && indexPath.section == 0 {
            print("Long press at item: \(indexPath.row)")
            showAlertButtonTapped(for: indexPath)
            } else {
                return
            }
        }
    }
    
    
    func setupLongGestureRecognizerOnCollection() {
                let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
                longPressGesture.minimumPressDuration = 1
                longPressGesture.delegate = self
                longPressGesture.delaysTouchesBegan = true
                collectionView?.addGestureRecognizer(longPressGesture)
            }
    
    
    
    
}
    

