//
//  APIrequest.swift
//  hammasir-final-project
//
//  Created by yalda saeedi on 6/29/1402 AP.
//

import Foundation
import UIKit
class APIrequest {
    
    private let apiKey = "service.dacdc7fa09f24697a84c58665958dcd0"

    typealias CompletionHandler = (String?) -> Void
    func getTheAddress(latitude: Double, longitude: Double, completion: @escaping CompletionHandler) {
        
        let apiKey = "service.dacdc7fa09f24697a84c58665958dcd0"
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
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            print("Response: \(responseString ?? "")")
            do {
                if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("jsonData", jsonData)

                    guard let formattedAddress = jsonData["formatted_address"] as? String else {
                        completion(nil)
                        return
                    }
                    
                    print("formattedAddress", formattedAddress)
                    completion(formattedAddress)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
