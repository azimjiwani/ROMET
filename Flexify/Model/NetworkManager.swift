//
//  NetworkManager.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let backendURL = Constants.backendURL
    
    func fetchExercises(completion: @escaping ([Exercise]?) -> Void) {
        // Replace the URL with your actual endpoint
        guard let url = URL(string: "\(backendURL)/get-all-exercises/") else {
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
    
    
    func uploadExerciseInfo(exercise: Exercise) {
//        let encoder = JSONEncoder()
//        
//        do {
//            // Encode the exercise data to JSON data
//            let jsonData = try encoder.encode(exercise)
//            
//            // Define the URL for your backend endpoint
//            guard let url = URL(string: "http://127.0.0.1:8000/upload-completed-exercise/") else {
//                print("Invalid URL")
//                return
//            }
//            
//            // Create a URLRequest
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonData
//            
//            // Perform the POST request
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                // Handle the response or error here
//            }
//            task.resume()
//            
//        } catch {
//            print("Error encoding exercise data: \(error.localizedDescription)")
//        }
    }
}
