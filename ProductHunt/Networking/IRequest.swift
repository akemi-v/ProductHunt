//
//  IRequest.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/10/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation

protocol IRequest : class {
    var urlRequest: URLRequest? { get }
}  
