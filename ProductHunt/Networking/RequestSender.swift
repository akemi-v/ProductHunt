//
//  RequestSender.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/11/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation
import Alamofire

class RequestSender : IRequestSender {
        
    func send<Model>(config: RequestConfig<Model>, completionHandler: @escaping (Result<Model>) -> Void) {
        
        guard let urlRequest = config.request.urlRequest else {
            print("URL error")
            return
        }
        
        Alamofire.request(urlRequest).responseJSON { response in
            
            if let error = response.error {
                completionHandler(Result.Fail(error.localizedDescription))
            }
            
            guard let data = response.data,
                let parsedModel: Model = config.parser.parse(data: data) else {
                    completionHandler(Result.Fail("Received data can't be parsed"))
                    return
            }
            
            completionHandler(Result.Success(parsedModel))
        }

    }
}
