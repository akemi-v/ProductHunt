//
//  CategoriesParser.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/10/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoriesParser : IParser {
    func parse(data: Data) -> [String]? {
        
        let json = JSON(data)
        
        guard let categories = json["topics"].array else {
            print("Categories parsing error")
            return nil
        }
        
        var categoriesNames = [String]()
        
        for category in categories {
            if let name = category["name"].string {
                categoriesNames.append(name)
            }
            
        }
        
        return categoriesNames
    }
}
