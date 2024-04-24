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
    
    func validateUsername(username: String, completion: @escaping(Bool) -> Void) {
            
        // Construct URL with username as a query parameter
        guard let url = URL(string: "\(Constants.backendURL)/verify-username/?userName=\(username)") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            
            if let isValid = try? JSONDecoder().decode(Bool.self, from: data) {
                DispatchQueue.main.async {
                    completion(isValid)
                }
            } else {
                print("Failed to decode response")
                completion(false)
            }
        }.resume()
    }
    
    func fetchProfileData(completion: @escaping (UserProfile?) -> Void) {
        guard let url = URL(string: "\(backendURL)/get-profile-data-app/?userName=\(User.shared.username)") else {
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
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                guard let result = jsonResponse?["result"] as? [String: Any] else {
                    print("Result key not found in JSON")
                    completion(nil)
                    return
                }
                
                let userProfile = UserProfile(json: result)
                DispatchQueue.main.async {
                    completion(userProfile)
                }
                
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchDashboardData(completion: @escaping (UserDashboard?) -> Void) {
        guard let url = URL(string: "\(backendURL)/get-dashboard-data-app/?userName=\(User.shared.username)") else {
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
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                guard let result = jsonResponse?["result"] as? [String: Any] else {
                    print("Result key not found in JSON")
                    completion(nil)
                    return
                }
                
                let userDashboard = UserDashboard(json: result)
                DispatchQueue.main.async {
                    completion(userDashboard)
                }
                
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    
    func fetchExercises(date: String, completion: @escaping ([Exercise]?) -> Void) {
        // Replace the URL with your actual endpoint
        guard let url = URL(string: "\(backendURL)/get-prescribed-exercises/?userName=\(User.shared.username)&date=\(date)") else {
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
    
    func postExercise(exercise: Exercise) {
        let encoder = JSONEncoder()
        
        do {
            // Convert Exercise to a dictionary
            let exerciseDict = try JSONSerialization.jsonObject(with: try JSONEncoder().encode(exercise), options: []) as! [String: Any]
            
            // Define the URL for your backend endpoint
            guard let uniqueId = exercise.uniqueId, let url = URL(string: "\(backendURL)/upload-completed-exercise/?userName=\(User.shared.username)&uniqueId=\(uniqueId)") else {
                print("Invalid URL")
                return
            }
            
            // Create a URLRequest
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: exerciseDict, options: [])
            
            // Perform the POST request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error making POST request: \(error.localizedDescription)")
                    return
                }
                
                // Check for response
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                
                // Check HTTP status code
                if (200...299).contains(httpResponse.statusCode) {
                    print("Exercise uploaded successfully")
                    // Handle success
                } else {
                    print("Failed to upload exercise. Status code: \(httpResponse.statusCode)")
                    // Handle failure
                }
            }
            task.resume()
            
        } catch {
            print("Error encoding exercise data: \(error.localizedDescription)")
        }
    }
}

