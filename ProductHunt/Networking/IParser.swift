//
//  IParser.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/10/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation

protocol IParser : class {
    associatedtype Model
    func parse(data: Data) -> Model?
}
