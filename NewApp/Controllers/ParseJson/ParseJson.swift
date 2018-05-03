//
//  ParseJson.swift
//  NewApp
//
//  Created by Ron Haimovich on 01/05/2018.
//  Copyright © 2018 Ron Haimovich. All rights reserved.
//

import UIKit

class ParseJson {
    
    static func getArticlesFromJson(completion:@escaping ([Article])->()){
        
        var myArticles = [Article]()
        var imageUrl = ""
        var title = ""
        var subTitle = ""
        var author = ""
        var date = ""
        var url = ""
        
        NetworkManager.checkArticlesUrl { (jsonObj) in
            guard let articles = jsonObj["articles"] as? [[String:Any]] else {
                print("articles error")
                return
            }
            
            for article in articles{

                title = checkObjInJson(objKeyInJson: "title", objFromJson: article)
                subTitle = checkObjInJson(objKeyInJson: "description", objFromJson: article)
                author = checkObjInJson(objKeyInJson: "author", objFromJson: article)
                imageUrl = checkObjInJson(objKeyInJson: "urlToImage", objFromJson: article)
                date = checkObjInJson(objKeyInJson: "publishedAt", objFromJson: article)
                url = checkObjInJson(objKeyInJson: "url", objFromJson: article)
                
                let myArticle = Article(imgUrl: imageUrl, title: title, subTitle: subTitle, author: author, date: date, url: url)
                myArticles.append(myArticle)
            }
            completion(myArticles)
        }
    }
    
    static func checkObjInJson(objKeyInJson:String,objFromJson:[String:Any])-> String{
        if let obj = objFromJson[objKeyInJson] as? String{
            return obj
        }else{
            print("no",objKeyInJson)
            return ""
        }
    }
}









