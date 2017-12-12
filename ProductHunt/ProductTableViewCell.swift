//
//  ProductTableViewCell.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/11/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upvotesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbnailImageView.image = UIImage(named: "pic_placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with product: ProductModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = product.name
            self.descriptionLabel.text = product.description
            self.upvotesCountLabel.text = "▲ \(product.upvotesCount)"
            self.thumbnailImageView.kf.indicatorType = .activity
            self.thumbnailImageView.kf.setImage(with: product.thumbnailUrl, placeholder: UIImage(named:"pic_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            self.thumbnailImageView.contentMode = .scaleAspectFill
            self.thumbnailImageView.clipsToBounds = true
        }
    }
    
}
