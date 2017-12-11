//
//  ProductsListViewController.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/9/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit
import DropDown

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dropDownButton: UIButton!
    let dropDown = DropDown()
    
    let model : IProductsListModel = ProductsListModel(requestSender: RequestSender())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDropdown()
        setupTableView()
        
        model.delegate = self
        
        let group = DispatchGroup()
        group.enter()
        
        model.fetchCategories {
            if let index = self.model.categories.index(of: "Tech"){
                self.navigationItem.title = "Tech"
                self.model.fetchProducts(forGiven: self.model.slugs[index])
                self.dropDown.selectRow(at: index)
            }
        }
        
        
        
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
            self?.model.fetchProducts(forGiven: (self?.model.slugs[index])!)
        }
    }
    
    // MARK: - Private methods
    
    private func setupDropdown() {
        dropDown.anchorView = dropDownButton
        dropDownButton.setTitle("Press to change category", for: .normal)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 144
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Product Cell Identifier")

    }
    
}

extension ProductsListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "Product Cell Identifier"
        var cell : ProductTableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ProductTableViewCell {
            cell = dequeuedCell
        } else {
            cell = ProductTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.configure(with: model.products[indexPath.row])
        
        return cell
    }
}

extension ProductsListViewController : UITableViewDelegate {
    
}

extension ProductsListViewController : IProductsListModelDelegate {

    func reload() {
        tableView.reloadData()
    }
}



