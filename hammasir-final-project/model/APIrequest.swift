//
//  APIrequest.swift
//  hammasir-final-project
//
//  Created by yalda saeedi on 6/29/1402 AP.
//

import Foundation
import UIKit

class APIrequest{
    
    func getTheAddress(latitude : Double, langitude : Double) -> String{
        print("in getTheAddress")
        let apiKey = "service.58b45e031d7d410e878ea7c46bb25415"
        let urlString = "https://api.neshan.org/v5/reverse?lat=\(latitude)&lng=\(langitude)"
        var responseStringCopy : String = ""
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return responseStringCopy
        }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Api-Key")
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {

                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                responseStringCopy = responseString!
                
            }
        }
        print("responseStringCopy")
        print(responseStringCopy)
        task.resume()
        return responseStringCopy
        
        
    }

    
}
