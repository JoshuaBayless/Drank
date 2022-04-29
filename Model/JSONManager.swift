//
//  JSONManager.swift
//  Drank
//
//  Created by Josh  Bayless on 3/22/22.
//

import UIKit



struct JSONManager {
    
    var cocktailURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    
    func fetchRandomCocktailData( completion: @escaping (Result<CocktailData, Error>) -> ())  {
        
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        performRequest(with: urlString, completion: completion)
    }
    
    func fetchCocktailData(for cocktailName: String, completion: @escaping (Result<CocktailData, Error>) -> ())  {
        let newCocktailName = cocktailName.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        let urlString = "\(cocktailURL)\(newCocktailName)"
        performRequest(with: urlString, completion: completion)
    }
    
    func performRequest<T:Decodable>(with urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let safeData = data {
                    if let cocktailInfo = self.parseJSON(safeData) as T? {
                        completion(.success(cocktailInfo))
                    }}
            }
            task.resume()
        }
    }
    
    func parseJSON<T:Decodable>(_ cocktailData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: cocktailData)
            return decodedData
            
        } catch {
            print(error)
            return nil
        }
    }
}
