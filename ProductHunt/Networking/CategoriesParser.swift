//
//  CategoriesParser.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/10/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoriesParser : Parser<([String], [String])> {
    override func parse(data: Data) -> ([String], [String])? {
        
        let json = JSON(data)
        
        guard let categories = json["topics"].array else {
            print("Categories parsing error")
            return nil
        }
        
        var categoriesNames = [String]()
        var categoriesSlugs = [String]()

        
        for category in categories {
            if let name = category["name"].string,
                let slug = category["slug"].string {
                categoriesNames.append(name)
                categoriesSlugs.append(slug)
            }
        }
        
        return (categoriesNames, categoriesSlugs)
    }
}
