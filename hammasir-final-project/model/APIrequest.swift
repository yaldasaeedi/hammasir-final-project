//
//  APIrequest.swift
//  hammasir-final-project
//
//  Created by yalda saeedi on 6/29/1402 AP.
//

import Foundation
import UIKit

class APIrequest {
    
    typealias CompletionHandler = (String?) -> Void
    
    func getTheAddress(latitude: Double, longitude: Double, completion: @escaping CompletionHandler) {
        let apiKey = "service.58b45e031d7d410e878ea7c46bb25415"
        let urlString = "https://api.neshan.org/v5/reverse?lat=\(latitude)&lng=\(longitude)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                
                if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = jsonData["results"] as? [[String: Any]],
                   let formattedAddress = results[0]["formatted_address"] as? String {
                    completion(formattedAddress)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
