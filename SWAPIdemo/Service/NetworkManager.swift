//
//  NetworkManager.swift
//  SWAPIdemo
//
//  Created by Ryan Dias on 2018/03/28.
//  Copyright © 2018 Ryan Dias. All rights reserved.
//

import Foundation

class NetworkManager {

    // MARK: Singleton setup
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    // MARK: Requests
    
    func get<T: Codable>(url: URL, success: ((T) -> Void)?, failure: ((Error) -> Void)?) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    failure?(error)
                } else if let jsonData = responseData {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        // Try to decode the JSON data
                        let person = try decoder.decode(T.self, from: jsonData)
                        success?(person)
                    } catch {
                        failure?(error)
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    failure?(error)
                }
            }
        }
        
        task.resume()
    }
    
}
