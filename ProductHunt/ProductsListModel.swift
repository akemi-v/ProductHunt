//
//  ProductsListModel.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/10/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation
import DropDown

protocol IProductsListModel : class {
    weak var delegate : IProductsListModelDelegate? { get set }
    
    var categories : [String] { get }
    
    func fetchCategories()
    func fetchProducts(forGiven category: String)
}

protocol IProductsListModelDelegate : class {
    var dropDown : DropDown { get }
    var dropDownButton: UIButton! { get }
}

class ProductsListModel : IProductsListModel {
    
    weak var delegate : IProductsListModelDelegate?
    
    var categories = [String]()
    var requestSender : IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func fetchCategories() {
        let config = RequestConfig<[String]>(request: CategoriesRequest(), parser: CategoriesParser())
        requestSender.send(config: config) { (result: Result<[String]>) in
            switch result {
            case .Success(let categories):
                self.categories = categories.sorted()
                self.delegate?.dropDown.dataSource = self.categories
            case .Fail(let error):
                print(error)
            }
        }
    }
    
    func fetchProducts(forGiven category: String) {
        
    }
    
}
