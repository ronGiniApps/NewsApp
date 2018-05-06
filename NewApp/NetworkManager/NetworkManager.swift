//
//  NetworkManager.swift
//  NewApp
//
//  Created by Ron Haimovich on 01/05/2018.
//  Copyright © 2018 Ron Haimovich. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    typealias JsonObject = [String:Any]
    
    static func checkArticlesUrl(completion:@escaping (JsonObject)->()){
        
        let newsUrlAddress = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7fa8f37f6a944ecfbb2ecc79cac8368d"
        
        guard let url = URL(string: newsUrlAddress)else {
            print("api url error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print(error)
                return
            }
            do{
                guard let data = data else {
                    print("no data from url")
                    return
                }
                guard let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? JsonObject else{return}
                completion(jsonObj)
                
            }catch let error as NSError {
                print(error.localizedDescription)
            }
            }.resume()
    }
}


