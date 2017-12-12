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
    var slugs : [String] { get }
    var products : [ProductModel] { get set }
    
    func fetchCategories(_ completionHandler: (() -> Void)?)
    func fetchProducts(forGiven category: String, _ completionHandler: (() -> Void)?)
}

protocol IProductsListModelDelegate : class {
    var dropDown : DropDown { get }
    
    func reload()
}

class ProductsListModel : IProductsListModel {
    
    weak var delegate : IProductsListModelDelegate?
    
    var categories = [String]()
    var slugs = [String]()
    var products = [ProductModel]()

    var requestSender : IRequestSender
    let categoriesRequest = CategoriesRequest()
    let postsRequest = PostsRequest()
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func fetchCategories(_ completionHandler: (() -> Void)?) {
        let config = RequestConfig<([String], [String])>(request: categoriesRequest, parser: CategoriesParser())
        requestSender.send(config: config) { (result: Result<([String], [String])>) in
            switch result {
            case .Success(let categories, let slugs):
                self.categories = categories.sorted { $0.caseInsensitiveCompare($1) == .orderedAscending }
                self.slugs = slugs.sorted()
                self.delegate?.dropDown.dataSource = self.categories
                
                if let handler = completionHandler {
                    handler()
                }
            case .Fail(let error):
                print(error)
            }
        }
    }
    
    func fetchProducts(forGiven category: String, _ completionHandler: (() -> Void)?) {
        
        postsRequest.topic = category
        
        let config = RequestConfig<[ProductModel]>(request: postsRequest, parser: PostsParser())
        requestSender.send(config: config) { (result: Result<[ProductModel]>) in
            switch result {
            case .Success(let posts):
                self.products = posts
                self.delegate?.reload()
                if let handler = completionHandler {
                    handler()
                }
            case .Fail(let error):
                print(error)
            }
        }
    }
    
}
