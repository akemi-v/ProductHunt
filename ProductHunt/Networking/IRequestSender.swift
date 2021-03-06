//
//  IRequestSender.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/11/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation

struct RequestConfig<Model> {
    let request : IRequest
    let parser : Parser<Model>
}

enum Result<T> {
    case Success(T)
    case Fail(String)
}

protocol IRequestSender : class {
    func send<Model>(config: RequestConfig<Model>, completionHandler: @escaping (Result<Model>) -> Void)
}
