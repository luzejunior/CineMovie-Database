//
//  GenericNetwork.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import Foundation

// Get json data from server
func getDataFromServer<T: Decodable>(path: String, completion: @escaping (T) -> (), error: @escaping (NetworkError) -> Void) {
    guard let url = URL(string: path) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        guard let data = data, err == nil else {
            print(err!)
            error(.ConnectionError)
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
            if httpResponse.statusCode == 200 {
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(jsonData)
                } catch let jsonErr {
                    error(.JsonError)
                    print(jsonErr.localizedDescription)
                }
            } else {
                error(.ResponseError)
            }
        }
    }.resume()
}
