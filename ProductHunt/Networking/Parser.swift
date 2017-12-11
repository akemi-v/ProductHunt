//
//  Parser.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/11/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation

class Parser<T> : IParser {
        
    typealias Model = T
    func parse(data: Data) -> T? { return nil }
}
