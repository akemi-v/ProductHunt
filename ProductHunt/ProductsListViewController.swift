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
    
    
    @IBOutlet weak var dropDownButton: UIButton!
    let dropDown = DropDown()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions

    @IBAction func showCategories(_ sender: UIButton) {
        dropDown.show()
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dropDownButton.setTitle(item, for: .normal)
        }
    }
    
    // MARK: - Private methods
    
    private func setupDropdown() {
        dropDown.anchorView = dropDownButton
        dropDown.dataSource = ["Car", "Kettenkrad"]
        dropDownButton.setTitle("Choose category", for: .normal)
    }
    
}


