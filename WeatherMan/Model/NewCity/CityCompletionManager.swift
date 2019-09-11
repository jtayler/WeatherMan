//
//  CityCompletionManager.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import Foundation

class CityCompletionManager: NSObject {
    
    var completionTask: URLSessionDataTask?
    
    func fetchPredictions(for search: String, _ completion: @escaping (_ results: [CityCompletion.Prediction]) -> Void) {
        guard let url = URL(string: API.APIURL.predictionRequest(for: search)) else {
            completion([])
            return
        }
        
        if let completionTask = completionTask {
            print("removing existing prediction thread")
            completionTask.cancel()
        }

        completionTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(CityCompletion.Result.self, from: data)
                print("decoded prediction result")
                completion(result.predictions)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
        
        completionTask?.resume()
    }
    
}
