//
//  NetworkManager.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchExercises(completion: @escaping ([Exercise]?) -> Void) {
        // Replace the URL with your actual endpoint
        guard let url = URL(string: "https://flexifybackend.vercel.app/get-all-exercises/") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                // Decode JSON data into a dictionary
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let resultArray = jsonDictionary["result"] as? [[String: Any]] {
                    
                    // Map the result array to an array of Exercise instances
                    let exercises = resultArray.compactMap { Exercise(json: $0) }
                    
                    // Update the state on the main thread
                    DispatchQueue.main.async {
                        completion(exercises)
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
