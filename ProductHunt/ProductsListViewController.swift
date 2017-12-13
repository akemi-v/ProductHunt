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
    
    let dropDownButton = UIButton()
    let dropDown = DropDown()
    
    let model : IProductsListModel = ProductsListModel(requestSender: RequestSender())
    
    let refreshControl : UIRefreshControl = UIRefreshControl()
    var currentSlug : String = "Tech"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDropdown()
        setupTableView()
        setupRefreshControl()
        
        model.delegate = self
        
        let group = DispatchGroup()
        group.enter()
        
        model.fetchCategories {
            if let index = self.model.categories.index(of: "Tech"){
                self.navigationItem.title = "Tech"
                self.model.fetchProducts(forGiven: self.model.slugs[index], nil)
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
            self?.dropDownButton.setTitle("\(category) ⌄", for: .normal)
            if let slug = self?.model.slugs[index] {
                self?.currentSlug = slug
                self?.model.fetchProducts(forGiven: slug, nil)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setupDropdown() {
        
        dropDown.anchorView = dropDownButton
        dropDownButton.setTitle("\(currentSlug) ⌄", for: .normal)
        dropDownButton.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: self.view.frame.width, height: 40))
        dropDownButton.setTitleColor(.black, for: .normal)
        self.navigationItem.titleView = dropDownButton
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(showCategories(_:)))
        dropDownButton.isUserInteractionEnabled = true
        dropDownButton.addGestureRecognizer(recognizer)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 144
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Product Cell Identifier")

    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: Any) {
        model.fetchProducts(forGiven: currentSlug) {
            self.refreshControl.endRefreshing()
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductVC") as? ProductViewController {
            productVC.product = model.products[indexPath.row]
            navigationController?.pushViewController(productVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ProductsListViewController : IProductsListModelDelegate {

    func reload() {
        tableView.reloadData()
    }
    
    func presentAlertMessage(_ alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
        self.refreshControl.endRefreshing()
    }
}



