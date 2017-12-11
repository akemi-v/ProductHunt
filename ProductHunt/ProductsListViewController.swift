//
//  ProductsListViewController.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/9/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit
import DropDown

class ProductsListViewController: UIViewController, IProductsListModelDelegate {
    
    
    @IBOutlet weak var dropDownButton: UIButton!
    let dropDown = DropDown()
    
    let model : IProductsListModel = ProductsListModel(requestSender: RequestSender())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDropdown()
        
        model.delegate = self
        model.fetchCategories()
        let index = model.categories.index(of: "Tech")
        navigationItem.title = "Tech"
        dropDown.selectRow(at: index)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions

    @IBAction func showCategories(_ sender: UIButton) {
        dropDown.show()
        
        dropDown.selectionAction = { [weak self] (index: Int, category: String) in
            self?.navigationItem.title = category
            self?.model.fetchProducts(forGiven: category)
        }
    }
    
    // MARK: - Private methods
    
    private func setupDropdown() {
        dropDown.anchorView = dropDownButton
        dropDownButton.setTitle("Press to change category", for: .normal)
    }
    
}



