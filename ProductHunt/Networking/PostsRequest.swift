//
//  PostsRequest.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/9/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation 

class PostsRequest : IRequest {
    
    private var baseUrl: String = "https://api.producthunt.com/"
    private var acсessToken: String = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    
    var topic: String = "tech"

    var urlRequest: URLRequest? {
        let urlString: String = "\(baseUrl)v1/categories/\(topic.lowercased())/posts/?access_token=\(acсessToken)"
        
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        
        return nil
    }
}
