//
//  ProductViewController.swift
//  ProductHunt
//
//  Created by Maria Semakova on 12/9/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upvotesCountLabel: UILabel!
    
    @IBOutlet weak var getItButton: UIButton!
    
    var product : ProductModel? = nil
    
    let screenshotSize = CGSize(width: 1480, height: 1037)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        
        guard let product = self.product else {
            print("No product model")
            return
        }
        
        imageScrollView.delegate = self
        
        DispatchQueue.main.async {
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.startAnimating()
            self.screenshotImageView.kf.setImage(with: product.screenshotUrl)
            self.screenshotImageView.kf.setImage(with: product.screenshotUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: {(image, error, cacheType, imageURL) -> () in
                self.activityIndicator.stopAnimating()
            })
            self.screenshotImageView.contentMode = .scaleToFill
            
            self.nameLabel.text = product.name
            self.descriptionLabel.text = product.description
            self.upvotesCountLabel.text = "▲ \(product.upvotesCount)"
            
            self.setZoomScale()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    
    @IBAction func getItButtonPressed(_ sender: UIButton) {
        if let url = product?.productUrl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Private methods
    
    private func setZoomScale() {
        let imageViewSize = screenshotSize
        let scrollViewSize = imageScrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        let minZoomScale = min(widthScale, heightScale)
        imageScrollView.minimumZoomScale = minZoomScale
        imageScrollView.setZoomScale(minZoomScale, animated: true)
    }

}

extension ProductViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return screenshotImageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        return
    }
}
