//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Derek Stengel on 4/26/24.
//

import UIKit

class StoreItemController: UIViewController {
    
    struct SearchResponse: Codable {
        let results: [StoreItem]
    }

    enum StoreItemError: Error, LocalizedError {
        case itemsNotFound
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw StoreItemError.itemsNotFound
        }
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        
        return searchResponse.results
    }
    
    func fetchArtworkImage(for item: StoreItem, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: item.artworkURL100) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(nil)
                return
            }
            
            completion(image)
        }
        task.resume()
    }
    
}
