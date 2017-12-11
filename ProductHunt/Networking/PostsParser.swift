//
//  PostsParser.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/9/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation
import SwiftyJSON

class PostsParser : Parser<[ProductModel]> {
    override func parse(data: Data) -> [ProductModel]? {
        
        let json = JSON(data)
        
        guard let posts = json["posts"].array else {
            print("Posts parsing error")
            return nil
        }
        
        var models = [ProductModel]()
        
        for post in posts {
            if let name = post["name"].string,
                let description = post["tagline"].string,
                let upvotesCount = post["votes_count"].int,
                let thumbnailUrl = post["thumbnail"]["image_url"].string,
                let productUrl = post["redirect_url"].string,
                let screenshotUrl = post["screenshot_url"]["850px"].string {
                
                let model = ProductModel(name: name, description: description, upvotesCount: upvotesCount, thumbnailUrl: thumbnailUrl, productUrl: productUrl, screenshotUrl: screenshotUrl)
                models.append(model)
            }

        }
        
        return models
    }
}
