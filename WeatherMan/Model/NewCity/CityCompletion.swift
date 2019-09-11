//
//  CityCompletion.swift
//  WeatherMan
//
//  Created by Jesse Tayler on 8/8/19.
//  Copyright © 2019 Jesse Tayler. All rights reserved.
//

import SwiftUI
import Combine

class CityCompletion: NSObject, ObservableObject, Identifiable {
    
    @Published var predictions: [CityCompletion.Prediction] = [] 
    
    private var completionManager: CityCompletionManager
    
    override init() {
        predictions = []
        completionManager = CityCompletionManager()
        super.init()
    }
    
    func search(_ search: String) {
        completionManager.fetchPredictions(for: search) { (predictions) in
            DispatchQueue.main.async {
                self.predictions = predictions
            }
        }
    }
    
}

extension CityCompletion {
    
    struct Result: Codable {
        var predictions: [Prediction]
        
        enum CodingKeys: String, CodingKey {
            case predictions = "predictions"
        }
    }
    
    struct Prediction: Codable, Identifiable {
        var id: String
        var description: String
        
        enum CodingKeys: String, CodingKey {
            case id = "place_id"
            case description = "description"
        }
    }
    
}
